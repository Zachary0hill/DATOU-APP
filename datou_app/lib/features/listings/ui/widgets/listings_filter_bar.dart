import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/models/models.dart';
import '../../../../core/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../logic/listings_providers.dart';

class ListingsFilterBar extends ConsumerStatefulWidget {
  const ListingsFilterBar({super.key});

  @override
  ConsumerState<ListingsFilterBar> createState() => _ListingsFilterBarState();
}

class _ListingsFilterBarState extends ConsumerState<ListingsFilterBar> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(listingsFiltersProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        'All Types',
                        filters.types.isEmpty,
                        () => _updateTypeFilters([]),
                      ),
                      const SizedBox(width: 8),
                      ...ListingType.values.map(
                        (type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildFilterChip(
                            _getTypeDisplayName(type),
                            filters.types.contains(type),
                            () => _toggleTypeFilter(type),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.tune),
                    if (_hasActiveFilters(filters))
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: kPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => _showAdvancedFilters(context),
              ),
            ],
          ),
          if (filters.isUrgent == true || filters.roles.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filters.isUrgent == true)
                  _buildActiveFilterChip(
                    'Urgent Only',
                    () => _updateIsUrgentFilter(null),
                  ),
                if (filters.roles.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  ...filters.roles.map(
                    (role) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildActiveFilterChip(
                        _getRoleDisplayName(role),
                        () => _removeRoleFilter(role),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? kPrimary : Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              Icons.close,
              size: 16,
              color: kPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleTypeFilter(ListingType type) {
    final currentFilters = ref.read(listingsFiltersProvider);
    final newTypes = currentFilters.types.contains(type)
        ? currentFilters.types.where((t) => t != type).toList()
        : [...currentFilters.types, type];
    _updateTypeFilters(newTypes);
  }

  void _updateTypeFilters(List<ListingType> types) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsFiltersProvider.notifier).state = 
        currentFilters.copyWith(types: types);
    ref.read(listingsProvider.notifier).refresh();
  }

  void _removeRoleFilter(UserRole role) {
    final currentFilters = ref.read(listingsFiltersProvider);
    final newRoles = currentFilters.roles.where((r) => r != role).toList();
    ref.read(listingsFiltersProvider.notifier).state = 
        currentFilters.copyWith(roles: newRoles);
    ref.read(listingsProvider.notifier).refresh();
  }

  void _updateIsUrgentFilter(bool? isUrgent) {
    final currentFilters = ref.read(listingsFiltersProvider);
    ref.read(listingsFiltersProvider.notifier).state = 
        currentFilters.copyWith(isUrgent: isUrgent);
    ref.read(listingsProvider.notifier).refresh();
  }

  bool _hasActiveFilters(ListingsFilters filters) {
    return filters.roles.isNotEmpty ||
           filters.minBudget != null ||
           filters.maxBudget != null ||
           filters.location?.isNotEmpty == true ||
           filters.isUrgent == true;
  }

  void _showAdvancedFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const _AdvancedFiltersSheet(),
    );
  }

  String _getTypeDisplayName(ListingType type) {
    switch (type) {
      case ListingType.photography:
        return 'Photography';
      case ListingType.videography:
        return 'Videography';
      case ListingType.modeling:
        return 'Modeling';
      case ListingType.casting:
        return 'Casting';
    }
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.photographer:
        return 'Photographer';
      case UserRole.videographer:
        return 'Videographer';
      case UserRole.model:
        return 'Model';
      case UserRole.agency:
        return 'Agency';
    }
  }
}

class _AdvancedFiltersSheet extends ConsumerStatefulWidget {
  const _AdvancedFiltersSheet();

  @override
  ConsumerState<_AdvancedFiltersSheet> createState() => _AdvancedFiltersSheetState();
}

class _AdvancedFiltersSheetState extends ConsumerState<_AdvancedFiltersSheet> {
  late ListingsFilters _tempFilters;
  final _locationController = TextEditingController();
  final _minBudgetController = TextEditingController();
  final _maxBudgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tempFilters = ref.read(listingsFiltersProvider);
    _locationController.text = _tempFilters.location ?? '';
    _minBudgetController.text = _tempFilters.minBudget?.toString() ?? '';
    _maxBudgetController.text = _tempFilters.maxBudget?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Advanced Filters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Required Role', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: UserRole.values.map((role) {
              final isSelected = _tempFilters.roles.contains(role);
              return FilterChip(
                label: Text(_getRoleDisplayName(role)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _tempFilters = _tempFilters.copyWith(
                        roles: [..._tempFilters.roles, role],
                      );
                    } else {
                      _tempFilters = _tempFilters.copyWith(
                        roles: _tempFilters.roles.where((r) => r != role).toList(),
                      );
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter city or area',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _tempFilters = _tempFilters.copyWith(location: value.isEmpty ? null : value);
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minBudgetController,
                  decoration: const InputDecoration(
                    labelText: 'Min Budget',
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final budget = double.tryParse(value);
                    _tempFilters = _tempFilters.copyWith(minBudget: budget);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxBudgetController,
                  decoration: const InputDecoration(
                    labelText: 'Max Budget',
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final budget = double.tryParse(value);
                    _tempFilters = _tempFilters.copyWith(maxBudget: budget);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Urgent only'),
            value: _tempFilters.isUrgent == true,
            onChanged: (value) {
              setState(() {
                _tempFilters = _tempFilters.copyWith(isUrgent: value ? true : null);
              });
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _tempFilters = const ListingsFilters();
                      _locationController.clear();
                      _minBudgetController.clear();
                      _maxBudgetController.clear();
                    });
                  },
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(listingsFiltersProvider.notifier).state = _tempFilters;
                    ref.read(listingsProvider.notifier).refresh();
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.photographer:
        return 'Photographer';
      case UserRole.videographer:
        return 'Videographer';
      case UserRole.model:
        return 'Model';
      case UserRole.agency:
        return 'Agency';
    }
  }
}