import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/models/models.dart';
import '../data/listings_repository.dart';

final listingsRepositoryProvider = Provider<ListingsRepository>((ref) {
  return ListingsRepository();
});

final listingsFiltersProvider = StateProvider<ListingFilters>((ref) {
  return const ListingFilters();
});

final listingsProvider = StateNotifierProvider<ListingsNotifier, AsyncValue<ListingSearchResult>>((ref) {
  return ListingsNotifier(ref);
});

final savedListingsProvider = StateNotifierProvider<SavedListingsNotifier, AsyncValue<List<Listing>>>((ref) {
  return SavedListingsNotifier(ref);
});

final categoryOptionsProvider = FutureProvider.family<List<String>, ListingType>((ref, type) {
  final repository = ref.read(listingsRepositoryProvider);
  return repository.getCategoryOptions(type);
});

final recommendedListingsProvider = FutureProvider<List<Listing>>((ref) {
  final repository = ref.read(listingsRepositoryProvider);
  return repository.getRecommendedListings();
});

final trendingSearchesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  final repository = ref.read(listingsRepositoryProvider);
  return repository.getTrendingSearches();
});

class ListingsNotifier extends StateNotifier<AsyncValue<ListingSearchResult>> {
  ListingsNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initializeLocation();
    loadListings();
  }

  final Ref ref;
  Position? _currentLocation;

  Future<void> _initializeLocation() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requestPermission = await Geolocator.requestPermission();
        if (requestPermission == LocationPermission.denied) {
          return; // No location access
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return; // Location permissions are permanently denied
      }

      _currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      // Update filters with user location
      final currentFilters = ref.read(listingsFiltersProvider);
      ref.read(listingsFiltersProvider.notifier).state = currentFilters.copyWith(
        userLat: _currentLocation?.latitude,
        userLng: _currentLocation?.longitude,
      );
    } catch (e) {
      // Location access failed, continue without location
      print('Failed to get location: $e');
    }
  }

  Future<void> loadListings({bool refresh = false}) async {
    if (refresh) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(listingsRepositoryProvider);
      final filters = ref.read(listingsFiltersProvider);

      final result = await repository.searchListings(
        refresh ? filters.copyWith(pageOffset: 0) : filters,
      );

      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMoreListings() async {
    final currentState = state;
    if (currentState is! AsyncData<ListingSearchResult>) return;

    final currentResult = currentState.value;
    if (!currentResult.hasMore) return;

    try {
      final repository = ref.read(listingsRepositoryProvider);
      final filters = ref.read(listingsFiltersProvider);
      
      final newFilters = filters.copyWith(
        pageOffset: filters.pageOffset + filters.pageLimit,
      );

      final newResult = await repository.searchListings(newFilters);
      
      // Merge results
      final mergedListings = [...currentResult.listings, ...newResult.listings];
      final mergedResult = ListingSearchResult(
        listings: mergedListings,
        totalCount: newResult.totalCount,
        hasMore: newResult.hasMore,
        currentPage: newResult.currentPage,
      );

      state = AsyncValue.data(mergedResult);
      
      // Update filters with new offset
      ref.read(listingsFiltersProvider.notifier).state = newFilters;
    } catch (error, stackTrace) {
      // Keep current state on error, just log
      print('Failed to load more listings: $error');
    }
  }

  Future<void> refresh() async {
    // Reset filters offset
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsFiltersProvider.notifier).state = currentFilters.copyWith(pageOffset: 0);
    
    await loadListings(refresh: true);
  }

  Future<void> updateFilters(ListingFilters newFilters) async {
    ref.read(listingsFiltersProvider.notifier).state = newFilters.copyWith(pageOffset: 0);
    await loadListings(refresh: true);
  }

  Future<bool> toggleSave(String listingId) async {
    try {
      final repository = ref.read(listingsRepositoryProvider);
      final isSaved = await repository.toggleSave(listingId);
      
      // Update the listing in current state
      final currentState = state;
      if (currentState is AsyncData<ListingSearchResult>) {
        final updatedListings = currentState.value.listings.map((listing) {
          if (listing.id == listingId) {
            return listing.copyWith(isSaved: isSaved);
          }
          return listing;
        }).toList();

        final updatedResult = currentState.value.copyWith(listings: updatedListings);
        state = AsyncValue.data(updatedResult);
      }
      
      return isSaved;
    } catch (e) {
      print('Failed to toggle save: $e');
      return false;
    }
  }

  bool get hasMoreData {
    final currentState = state;
    return currentState is AsyncData<ListingSearchResult> ? currentState.value.hasMore : false;
  }
}

class SavedListingsNotifier extends StateNotifier<AsyncValue<List<Listing>>> {
  SavedListingsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadSavedListings();
  }

  final Ref ref;

  Future<void> loadSavedListings({bool refresh = false}) async {
    if (refresh) {
      state = const AsyncValue.loading();
    }

    try {
      final repository = ref.read(listingsRepositoryProvider);
      final savedListings = await repository.getSavedListings();
      state = AsyncValue.data(savedListings);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadSavedListings(refresh: true);
  }
}