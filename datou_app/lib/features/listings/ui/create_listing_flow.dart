import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/models/models.dart';
import '../../../core/constants.dart';
import '../../../core/theme/app_colors.dart';

enum CreateListingStep { details, requirements, schedule, payment }

class CreateListingFlow extends HookConsumerWidget {
  const CreateListingFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = useState(CreateListingStep.details);
    final pageController = usePageController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
            _buildHeader(context, currentStep.value),
            _buildProgressIndicator(currentStep.value),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  currentStep.value = CreateListingStep.values[index];
                },
                children: [
                  _DetailsStep(
                    onNext: () => _nextStep(pageController, currentStep),
                  ),
                  _RequirementsStep(
                    onNext: () => _nextStep(pageController, currentStep),
                    onBack: () => _previousStep(pageController, currentStep),
                  ),
                  _ScheduleStep(
                    onNext: () => _nextStep(pageController, currentStep),
                    onBack: () => _previousStep(pageController, currentStep),
                  ),
                  _PaymentStep(
                    onBack: () => _previousStep(pageController, currentStep),
                    onComplete: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CreateListingStep currentStep) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          Text(
            _getStepTitle(currentStep),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 60), // Balance the cancel button
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(CreateListingStep currentStep) {
    final stepIndex = CreateListingStep.values.indexOf(currentStep);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: CreateListingStep.values.asMap().entries.map((entry) {
          final index = entry.key;
          final isActive = index <= stepIndex;
          
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < 3 ? 8 : 0),
              decoration: BoxDecoration(
                color: isActive ? kPrimary : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _nextStep(PageController pageController, ValueNotifier<CreateListingStep> currentStep) {
    final nextIndex = CreateListingStep.values.indexOf(currentStep.value) + 1;
    if (nextIndex < CreateListingStep.values.length) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep(PageController pageController, ValueNotifier<CreateListingStep> currentStep) {
    final previousIndex = CreateListingStep.values.indexOf(currentStep.value) - 1;
    if (previousIndex >= 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _getStepTitle(CreateListingStep step) {
    switch (step) {
      case CreateListingStep.details:
        return 'Listing Details';
      case CreateListingStep.requirements:
        return 'Requirements';
      case CreateListingStep.schedule:
        return 'Schedule & Location';
      case CreateListingStep.payment:
        return 'Budget & Payment';
    }
  }
}

class _DetailsStep extends HookConsumerWidget {
  const _DetailsStep({required this.onNext});
  
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final selectedType = useState<ListingType?>(null);
    final selectedImages = useState<List<XFile>>([]);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What type of project is this?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ListingType.values.map((type) {
                final isSelected = selectedType.value == type;
                return GestureDetector(
                  onTap: () => selectedType.value = type,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? kPrimary : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? kPrimary : Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getTypeIcon(type),
                          color: isSelected ? Colors.white : Colors.grey[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getTypeDisplayName(type),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Project Title',
                hintText: 'Enter a descriptive title for your project',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your project requirements, style, and expectations...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Project Images (Optional)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => _pickImages(selectedImages),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.camera),
                      SizedBox(width: 4),
                      Text('Add Photos'),
                    ],
                  ),
                ),
              ],
            ),
            if (selectedImages.value.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              selectedImages.value[index].path,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image);
                              },
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                final newImages = List<XFile>.from(selectedImages.value);
                                newImages.removeAt(index);
                                selectedImages.value = newImages;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    if (selectedType.value != null) {
                      onNext();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a project type')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages(ValueNotifier<List<XFile>> selectedImages) async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    selectedImages.value = [...selectedImages.value, ...images];
  }

  IconData _getTypeIcon(ListingType type) {
    switch (type) {
      case ListingType.photography:
        return Icons.camera_alt;
      case ListingType.videography:
        return Icons.videocam;
      case ListingType.modeling:
        return Icons.person;
      case ListingType.casting:
        return Icons.group;
    }
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
}

class _RequirementsStep extends HookConsumerWidget {
  const _RequirementsStep({
    required this.onNext,
    required this.onBack,
  });
  
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = useState<UserRole?>(null);
    final experienceYears = useState<int?>(null);
    final requiredSkills = useState<List<String>>([]);
    final skillController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Who are you looking for?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: UserRole.values.map((role) {
              final isSelected = selectedRole.value == role;
              return GestureDetector(
                onTap: () => selectedRole.value = role,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimary : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? kPrimary : Colors.grey,
                    ),
                  ),
                  child: Text(
                    _getRoleDisplayName(role),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Experience Level',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            value: experienceYears.value,
            decoration: const InputDecoration(
              hintText: 'Select minimum years of experience',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(value: 0, child: Text('Any experience level')),
              const DropdownMenuItem(value: 1, child: Text('1+ years')),
              const DropdownMenuItem(value: 3, child: Text('3+ years')),
              const DropdownMenuItem(value: 5, child: Text('5+ years')),
              const DropdownMenuItem(value: 10, child: Text('10+ years')),
            ],
            onChanged: (value) => experienceYears.value = value,
          ),
          const SizedBox(height: 24),
          const Text(
            'Required Skills/Equipment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: skillController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a skill or equipment requirement',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  final skill = skillController.text.trim();
                  if (skill.isNotEmpty && !requiredSkills.value.contains(skill)) {
                    requiredSkills.value = [...requiredSkills.value, skill];
                    skillController.clear();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
          if (requiredSkills.value.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: requiredSkills.value.map((skill) {
                return Chip(
                  label: Text(skill),
                  onDeleted: () {
                    requiredSkills.value = requiredSkills.value
                        .where((s) => s != skill)
                        .toList();
                  },
                );
              }).toList(),
            ),
          ],
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Next'),
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

class _ScheduleStep extends HookConsumerWidget {
  const _ScheduleStep({
    required this.onNext,
    required this.onBack,
  });
  
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState<DateTime?>(null);
    final durationHours = useState<int?>(null);
    final locationController = useTextEditingController();
    final applicationDeadline = useState<DateTime?>(null);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'When and where?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter the event location',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _selectDate(context, selectedDate),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                    selectedDate.value != null
                        ? '${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}'
                        : 'Select Event Date',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: durationHours.value,
                  decoration: const InputDecoration(
                    hintText: 'Duration (hours)',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(12, (index) {
                    final hours = index + 1;
                    return DropdownMenuItem(
                      value: hours,
                      child: Text('$hours hour${hours > 1 ? 's' : ''}'),
                    );
                  }),
                  onChanged: (value) => durationHours.value = value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Application Deadline',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _selectDate(context, applicationDeadline),
            icon: const Icon(Icons.schedule),
            label: Text(
              applicationDeadline.value != null
                  ? '${applicationDeadline.value!.day}/${applicationDeadline.value!.month}/${applicationDeadline.value!.year}'
                  : 'Select Application Deadline',
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, ValueNotifier<DateTime?> dateNotifier) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      dateNotifier.value = date;
    }
  }
}

class _PaymentStep extends HookConsumerWidget {
  const _PaymentStep({
    required this.onBack,
    required this.onComplete,
  });
  
  final VoidCallback onBack;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetController = useTextEditingController();
    final isNegotiable = useState(true);
    final isUrgent = useState(false);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget & Payment',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Budget',
              hintText: 'Enter your budget amount',
              border: OutlineInputBorder(),
              prefixText: '\$',
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Budget is negotiable'),
            subtitle: const Text('Allow professionals to propose different rates'),
            value: isNegotiable.value,
            onChanged: (value) => isNegotiable.value = value,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Mark as urgent'),
            subtitle: const Text('This will boost your listing visibility'),
            value: isUrgent.value,
            onChanged: (value) => isUrgent.value = value,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Protection',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                Text(
                  'Your payment will be held securely until the work is completed. '
                  'A 5% platform fee will be added to the final amount.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Back'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Save listing and create payment intent
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Listing created successfully!'),
                      ),
                    );
                    onComplete();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Create Listing'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}