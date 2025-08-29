import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/models/models.dart';
import '../logic/listings_providers.dart';

class ListingsScreen extends HookConsumerWidget {
  const ListingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final searchController = useTextEditingController();
    final searchFocusNode = useFocusNode();
    final isSearchActive = useState(false);
    final selectedRoleType = useState<ListingType?>(null);
    final selectedCategories = useState<Set<String>>({});
    final showFilters = useState(false);

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
    final filters = ref.watch(listingsFiltersProvider);
    final hasMoreData = ref.read(listingsProvider.notifier).hasMoreData;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search and filter actions
            _buildHeader(context, isSearchActive, searchController, searchFocusNode, showFilters, ref),
            
            // Role chips (All, Photography, Video, Modeling)
            _buildRoleChips(selectedRoleType, ref),
            
            // Secondary category chips (dynamic based on selected role)
            if (selectedRoleType.value != null)
              _buildCategoryChips(selectedRoleType.value!, selectedCategories, ref),
            
            // Sort and view toggle
            _buildSortAndViewToggle(filters, ref),
            
            // Advanced filters panel (collapsible)
            if (showFilters.value)
              _buildAdvancedFilters(context, filters, ref),
            
            // Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(listingsProvider.notifier).refresh(),
                child: listingsAsync.when(
                  data: (result) {
                    if (result.listings.isEmpty) {
                      return _EmptyState(
                        hasFilters: _hasActiveFilters(filters),
                        onClearFilters: () => _clearAllFilters(ref, selectedRoleType, selectedCategories),
                      );
                    }

                    return _buildListingsView(context, result, scrollController, hasMoreData, ref);
                  },
                  loading: () => const _LoadingState(),
                  error: (error, stackTrace) => _ErrorState(
                    error: error.toString(),
                    onRetry: () => ref.read(listingsProvider.notifier).refresh(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header with search and filter actions
  Widget _buildHeader(BuildContext context, ValueNotifier<bool> isSearchActive, 
      TextEditingController searchController, FocusNode searchFocusNode, 
      ValueNotifier<bool> showFilters, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Title and Action Buttons
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Listings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Search Button
              IconButton(
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
                icon: Icon(
                  isSearchActive.value ? Icons.close : Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              // Filter Button
              IconButton(
                onPressed: () {
                  showFilters.value = !showFilters.value;
                },
                icon: Icon(
                  Icons.tune,
                  color: showFilters.value ? const Color(0xFF8B5CF6) : Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          
          // Search Bar (when active)
          if (isSearchActive.value) ...[
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[700]!),
              ),
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search listings, skills, locations...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[400]),
                          onPressed: () {
                            searchController.clear();
                            _updateSearch(ref, '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                onChanged: (value) => _updateSearch(ref, value),
                onSubmitted: (value) => _updateSearch(ref, value),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Role chips (All, Photography, Video, Modeling)
  Widget _buildRoleChips(ValueNotifier<ListingType?> selectedRoleType, WidgetRef ref) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildRoleChip(
            'All',
            selectedRoleType.value == null,
            () {
              selectedRoleType.value = null;
              _updateRoleFilter(ref, null);
            },
          ),
          const SizedBox(width: 12),
          _buildRoleChip(
            'Photography',
            selectedRoleType.value == ListingType.photography,
            () {
              selectedRoleType.value = ListingType.photography;
              _updateRoleFilter(ref, ListingType.photography);
            },
          ),
          const SizedBox(width: 12),
          _buildRoleChip(
            'Video',
            selectedRoleType.value == ListingType.videography,
            () {
              selectedRoleType.value = ListingType.videography;
              _updateRoleFilter(ref, ListingType.videography);
            },
          ),
          const SizedBox(width: 12),
          _buildRoleChip(
            'Modeling',
            selectedRoleType.value == ListingType.modeling,
            () {
              selectedRoleType.value = ListingType.modeling;
              _updateRoleFilter(ref, ListingType.modeling);
            },
          ),
          const SizedBox(width: 12),
          _buildRoleChip(
            'Casting',
            selectedRoleType.value == ListingType.casting,
            () {
              selectedRoleType.value = ListingType.casting;
              _updateRoleFilter(ref, ListingType.casting);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[700]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[300],
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Secondary category chips (dynamic based on role)
  Widget _buildCategoryChips(ListingType roleType, ValueNotifier<Set<String>> selectedCategories, WidgetRef ref) {
    final categoryOptions = _getCategoryOptions(roleType);
    
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categoryOptions.length,
        itemBuilder: (context, index) {
          final category = categoryOptions[index];
          final isSelected = selectedCategories.value.contains(category);
          
          return Padding(
            padding: EdgeInsets.only(right: index < categoryOptions.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () {
                final newSelection = Set<String>.from(selectedCategories.value);
                if (isSelected) {
                  newSelection.remove(category);
                } else {
                  newSelection.add(category);
                }
                selectedCategories.value = newSelection;
                _updateCategoryFilter(ref, roleType, newSelection);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8B5CF6).withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[600]!,
                  ),
                ),
                child: Text(
                  _formatCategoryName(category),
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF8B5CF6) : Colors.grey[400],
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Sort and view toggle
  Widget _buildSortAndViewToggle(ListingFilters filters, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Sort dropdown
          Expanded(
            child: GestureDetector(
              onTap: () => _showSortOptions(ref),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[700]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sort, color: Colors.grey[400], size: 18),
                    const SizedBox(width: 8),
                    Text(
                      _getSortLabel(filters.sortBy),
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey[400], size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // View toggle
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[700]!),
            ),
            child: Row(
              children: [
                _buildViewToggle(
                  Icons.list,
                  filters.viewMode == ViewMode.list,
                  () => _updateViewMode(ref, ViewMode.list),
                ),
                _buildViewToggle(
                  Icons.map,
                  filters.viewMode == ViewMode.map,
                  () => _updateViewMode(ref, ViewMode.map),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle(IconData icon, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[400],
          size: 18,
        ),
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, dynamic listing) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: ${listing.title}'),
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with avatar and info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFF8B5CF6),
                      child: Text(
                        listing.clientName?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listing.clientName ?? 'Anonymous Client',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            listing.location ?? 'Location not specified',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(listing.type),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        listing.type.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Title and Description
                Text(
                  listing.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  listing.description,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // Budget and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Text(
                        '\$${listing.budget?.toStringAsFixed(0) ?? 'TBD'}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      _formatDate(listing.eventDate),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(dynamic type) {
    switch (type.name) {
      case 'photography':
        return Colors.blue;
      case 'videography':
        return Colors.purple;
      case 'modeling':
        return Colors.pink;
      case 'event':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date TBD';
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 7) return 'In $difference days';
    
    return '${date.month}/${date.day}/${date.year}';
  }

  // Advanced filters panel
  Widget _buildAdvancedFilters(BuildContext context, ListingFilters filters, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Advanced Filters',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          // Budget range
          Text(
            'Budget Range',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Min',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixText: '\$',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8B5CF6)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Max',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixText: '\$',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8B5CF6)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Quick filter toggles
          Row(
            children: [
              _buildFilterToggle(
                'Urgent Only',
                filters.urgentOnly,
                () => _updateUrgentFilter(ref, !filters.urgentOnly),
              ),
              const SizedBox(width: 12),
              _buildFilterToggle(
                'Remote OK',
                filters.includeRemote,
                () => _updateRemoteFilter(ref, !filters.includeRemote),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterToggle(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF8B5CF6).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? const Color(0xFF8B5CF6) : Colors.grey[600]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF8B5CF6) : Colors.grey[400],
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Listings view (list or map)
  Widget _buildListingsView(BuildContext context, ListingSearchResult result, 
      ScrollController scrollController, bool hasMoreData, WidgetRef ref) {
    final filters = ref.watch(listingsFiltersProvider);
    
    if (filters.viewMode == ViewMode.map) {
      return _buildMapView(result.listings, ref);
    }
    
    return ListView.builder(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      itemCount: result.listings.length + (hasMoreData ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == result.listings.length) {
          return const _LoadingItem();
        }

        final listing = result.listings[index];
        return _buildEnhancedListingCard(context, listing, ref);
      },
    );
  }

  Widget _buildMapView(List<Listing> listings, WidgetRef ref) {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Map View',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Map integration coming soon',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced listing card with save functionality
  Widget _buildEnhancedListingCard(BuildContext context, Listing listing, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to listing detail
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: ${listing.title}'),
                backgroundColor: const Color(0xFF8B5CF6),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with save button
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(listing.type),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        listing.type.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (listing.isUrgent) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'URGENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (listing.distanceKm != null) ...[
                      Icon(Icons.location_on, color: Colors.grey[400], size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${listing.distanceKm!.toStringAsFixed(1)}km',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    GestureDetector(
                      onTap: () async {
                        await ref.read(listingsProvider.notifier).toggleSave(listing.id);
                      },
                      child: Icon(
                        listing.isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: listing.isSaved ? const Color(0xFF8B5CF6) : Colors.grey[400],
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Title and Description
                Text(
                  listing.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  listing.description,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12),
                
                // Location and Date
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.grey[400], size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        listing.locationText,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (listing.eventDate != null) ...[
                      Icon(Icons.calendar_today, color: Colors.grey[400], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(listing.eventDate!),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Budget and Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (listing.budget != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Text(
                          '\$${listing.budget!.toStringAsFixed(0)}${listing.isNegotiable ? ' (neg)' : ''}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.grey[500], size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${listing.viewCount}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.bookmark, color: Colors.grey[500], size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${listing.saveCount}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods
  List<String> _getCategoryOptions(ListingType type) {
    switch (type) {
      case ListingType.photography:
        return ['portrait', 'wedding', 'event', 'commercial', 'fashion', 'product', 'automotive', 'real_estate'];
      case ListingType.videography:
        return ['commercial', 'wedding', 'music_video', 'documentary', 'corporate', 'social_media', 'event'];
      case ListingType.modeling:
        return ['fashion', 'commercial', 'fitness', 'beauty', 'lifestyle', 'automotive', 'product'];
      case ListingType.casting:
        return ['film', 'tv', 'commercial', 'theater', 'voice_over', 'background'];
    }
  }

  String _formatCategoryName(String category) {
    return category.split('_').map((word) => 
        word[0].toUpperCase() + word.substring(1)).join(' ');
  }

  String _getSortLabel(SortOption sort) {
    switch (sort) {
      case SortOption.newest:
        return 'Newest';
      case SortOption.oldest:
        return 'Oldest';
      case SortOption.budget_high:
        return 'Budget: High to Low';
      case SortOption.budget_low:
        return 'Budget: Low to High';
      case SortOption.deadline:
        return 'Deadline';
      case SortOption.recommended:
        return 'Recommended';
    }
  }

  bool _hasActiveFilters(ListingFilters filters) {
    return filters.searchQuery?.isNotEmpty == true ||
           filters.types?.isNotEmpty == true ||
           filters.categories?.isNotEmpty == true ||
           filters.minBudget != null ||
           filters.maxBudget != null ||
           filters.urgentOnly ||
           !filters.includeRemote;
  }

  void _clearAllFilters(WidgetRef ref, ValueNotifier<ListingType?> selectedRoleType, 
      ValueNotifier<Set<String>> selectedCategories) {
    selectedRoleType.value = null;
    selectedCategories.value = {};
    ref.read(listingsFiltersProvider.notifier).state = const ListingFilters();
    ref.read(listingsProvider.notifier).refresh();
  }

  void _updateSearch(WidgetRef ref, String query) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(searchQuery: query.isEmpty ? null : query),
    );
  }

  void _updateRoleFilter(WidgetRef ref, ListingType? type) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(
        types: type != null ? [type] : null,
        categories: {}, // Clear categories when changing role
      ),
    );
  }

  void _updateCategoryFilter(WidgetRef ref, ListingType roleType, Set<String> categories) {
    final currentFilters = ref.read(listingsFiltersProvider);
    final categoryMap = categories.isNotEmpty 
        ? {roleType.name: categories.toList()}
        : <String, List<String>>{};
    
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(categories: categoryMap),
    );
  }

  void _updateViewMode(WidgetRef ref, ViewMode viewMode) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsFiltersProvider.notifier).state = 
        currentFilters.copyWith(viewMode: viewMode);
  }

  void _updateUrgentFilter(WidgetRef ref, bool urgentOnly) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(urgentOnly: urgentOnly),
    );
  }

  void _updateRemoteFilter(WidgetRef ref, bool includeRemote) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(includeRemote: includeRemote),
    );
  }

  void _showSortOptions(WidgetRef ref) {
    // This would show a bottom sheet with sort options
    // For now, just cycle through sort options
    final currentFilters = ref.read(listingsFiltersProvider);
    final sortOptions = SortOption.values;
    final currentIndex = sortOptions.indexOf(currentFilters.sortBy);
    final nextIndex = (currentIndex + 1) % sortOptions.length;
    
    ref.read(listingsProvider.notifier).updateFilters(
      currentFilters.copyWith(sortBy: sortOptions[nextIndex]),
    );
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
      // Match the content list's bottom padding to avoid partial occlusion
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
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
  const _EmptyState({
    required this.hasFilters,
    required this.onClearFilters,
  });

  final bool hasFilters;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasFilters ? Icons.filter_alt_off : Icons.work_outline,
              size: 80,
              color: Colors.grey[500],
            ),
            const SizedBox(height: 24),
            Text(
              hasFilters ? 'No listings match your filters' : 'No listings available',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              hasFilters 
                  ? 'Try adjusting your search terms or filters to see more results'
                  : 'Check back later for new opportunities',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasFilters) ...[
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onClearFilters,
                    borderRadius: BorderRadius.circular(25),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(
                        'Clear All Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onRetry,
                  borderRadius: BorderRadius.circular(25),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}