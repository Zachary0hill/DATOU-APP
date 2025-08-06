import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/theme/app_colors.dart';
import '../logic/listings_providers.dart';
import 'widgets/listing_card.dart';
import 'widgets/listings_filter_bar.dart';

class ListingsScreen extends HookConsumerWidget {
  const ListingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final isSearchActive = useState(false);

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >= 
            scrollController.position.maxScrollExtent - 200) {
          ref.read(listingsProvider.notifier).loadMoreListings();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    final listingsAsync = ref.watch(listingsProvider);
    final hasMoreData = ref.read(listingsProvider.notifier).hasMoreData;

    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: isSearchActive.value ? 120 : 80,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kPrimary.withOpacity(0.1),
                        kSecondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
                title: isSearchActive.value
                    ? null
                    : const Text(
                        'Listings',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                centerTitle: true,
              ),
              bottom: isSearchActive.value
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: searchController,
                          focusNode: searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Search listings...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                _updateSearch(ref, '');
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                          ),
                          onChanged: (value) => _updateSearch(ref, value),
                          onSubmitted: (value) => _updateSearch(ref, value),
                        ),
                      ),
                    )
                  : null,
              actions: [
                IconButton(
                  icon: Icon(
                    isSearchActive.value ? Icons.close : Icons.search,
                  ),
                  onPressed: () {
                    if (isSearchActive.value) {
                      isSearchActive.value = false;
                      searchController.clear();
                      _updateSearch(ref, '');
                      searchFocusNode.unfocus();
                    } else {
                      isSearchActive.value = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        searchFocusNode.requestFocus();
                      });
                    }
                  },
                ),
              ],
            ),
            const SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                child: ListingsFilterBar(),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () => ref.read(listingsProvider.notifier).refresh(),
          child: listingsAsync.when(
            data: (listings) {
              if (listings.isEmpty) {
                return const _EmptyState();
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: listings.length + (hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == listings.length) {
                    return const _LoadingItem();
                  }

                  final listing = listings[index];
                  return ListingCard(
                    listing: listing,
                    onTap: () {
                      // TODO: Navigate to listing detail
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${listing.title}'),
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const _LoadingState(),
            error: (error, stackTrace) => _ErrorState(
              error: error.toString(),
              onRetry: () => ref.read(listingsProvider.notifier).refresh(),
            ),
          ),
        ),
      ),
    );
  }

  void _updateSearch(WidgetRef ref, String query) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsFiltersProvider.notifier).state = 
        currentFilters.copyWith(searchQuery: query.isEmpty ? null : query);
    ref.read(listingsProvider.notifier).refresh();
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _StickyHeaderDelegate({required this.child});
  
  final Widget child;

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 120;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: 5,
      itemBuilder: (context, index) => const _ShimmerListingCard(),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ShimmerListingCard extends StatelessWidget {
  const _ShimmerListingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 200,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 60,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No listings found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}