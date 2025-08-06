import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import '../../../core/constants.dart';
import '../data/listings_repository.dart';

final listingsRepositoryProvider = Provider<ListingsRepository>((ref) {
  return ListingsRepository();
});

class ListingsFilters {
  const ListingsFilters({
    this.searchQuery,
    this.types = const [],
    this.roles = const [],
    this.minBudget,
    this.maxBudget,
    this.location,
    this.isUrgent,
  });

  final String? searchQuery;
  final List<ListingType> types;
  final List<UserRole> roles;
  final double? minBudget;
  final double? maxBudget;
  final String? location;
  final bool? isUrgent;

  ListingsFilters copyWith({
    String? searchQuery,
    List<ListingType>? types,
    List<UserRole>? roles,
    double? minBudget,
    double? maxBudget,
    String? location,
    bool? isUrgent,
  }) {
    return ListingsFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      types: types ?? this.types,
      roles: roles ?? this.roles,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      location: location ?? this.location,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}

final listingsFiltersProvider = StateProvider<ListingsFilters>((ref) {
  return const ListingsFilters();
});

final listingsProvider = StateNotifierProvider<ListingsNotifier, AsyncValue<List<Listing>>>((ref) {
  return ListingsNotifier(ref);
});

class ListingsNotifier extends StateNotifier<AsyncValue<List<Listing>>> {
  ListingsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadListings();
  }

  final Ref ref;
  final List<Listing> _allListings = [];
  int _currentPage = 0;
  bool _hasMoreData = true;
  static const int _pageSize = 20;

  Future<void> loadListings({bool refresh = false}) async {
    if (refresh) {
      _allListings.clear();
      _currentPage = 0;
      _hasMoreData = true;
      state = const AsyncValue.loading();
    }

    if (!_hasMoreData) return;

    try {
      final repository = ref.read(listingsRepositoryProvider);
      final filters = ref.read(listingsFiltersProvider);

      final newListings = await repository.getListings(
        limit: _pageSize,
        offset: _currentPage * _pageSize,
        searchQuery: filters.searchQuery,
        types: filters.types.isEmpty ? null : filters.types,
        roles: filters.roles.isEmpty ? null : filters.roles,
        minBudget: filters.minBudget,
        maxBudget: filters.maxBudget,
        location: filters.location,
        isUrgent: filters.isUrgent,
      );

      if (newListings.length < _pageSize) {
        _hasMoreData = false;
      }

      _allListings.addAll(newListings);
      _currentPage++;

      state = AsyncValue.data(List.from(_allListings));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadListings(refresh: true);
  }

  Future<void> loadMoreListings() async {
    await loadListings();
  }

  bool get hasMoreData => _hasMoreData;
}