import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../data/calendar_models.dart';
import '../logic/calendar_providers.dart';
import '../../auth/logic/auth_providers.dart';

class CreateEventScreen extends HookConsumerWidget {
  final DateTime? initialDate;

  const CreateEventScreen({
    super.key,
    this.initialDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final locationController = TextEditingController();
    
    final selectedDate = ref.watch(_selectedDateProvider);
    final selectedStartTime = ref.watch(_selectedStartTimeProvider);
    final selectedEndTime = ref.watch(_selectedEndTimeProvider);
    final selectedEventType = ref.watch(_selectedEventTypeProvider);
    final isLoading = ref.watch(_createEventLoadingProvider);

    // Initialize with provided date or current date
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialDate != null) {
        ref.read(_selectedDateProvider.notifier).state = initialDate!;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        actions: [
          TextButton(
            onPressed: isLoading
                ? null
                : () => _createEvent(
                      context,
                      ref,
                      formKey,
                      titleController,
                      descriptionController,
                      locationController,
                    ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Title
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Event Title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an event title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Event Type
            DropdownButtonFormField<EventType>(
              value: selectedEventType,
              decoration: const InputDecoration(
                labelText: 'Event Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: EventType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(_getEventTypeIcon(type), color: _getEventTypeColor(type)),
                      const SizedBox(width: 8),
                      Text(_formatEventType(type)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(_selectedEventTypeProvider.notifier).state = value;
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select an event type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Date
            InkWell(
              onTap: () => _selectDate(context, ref),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  DateFormat('EEEE, MMM d, y').format(selectedDate),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Time Range
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectStartTime(context, ref),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        selectedStartTime.format(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectEndTime(context, ref),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      child: Text(
                        selectedEndTime.format(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Location
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
                hintText: 'Enter event location',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                hintText: 'Add event details...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // Create Button
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () => _createEvent(
                        context,
                        ref,
                        formKey,
                        titleController,
                        descriptionController,
                        locationController,
                      ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 16),
                        Text('Creating Event...'),
                      ],
                    )
                  : const Text(
                      'Create Event',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final currentDate = ref.read(_selectedDateProvider);
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      ref.read(_selectedDateProvider.notifier).state = picked;
    }
  }

  Future<void> _selectStartTime(BuildContext context, WidgetRef ref) async {
    final currentTime = ref.read(_selectedStartTimeProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    
    if (picked != null) {
      ref.read(_selectedStartTimeProvider.notifier).state = picked;
      
      // Auto-adjust end time to be 1 hour after start time if it's before start time
      final endTime = ref.read(_selectedEndTimeProvider);
      final startTimeAsDateTime = DateTime(2024, 1, 1, picked.hour, picked.minute);
      final endTimeAsDateTime = DateTime(2024, 1, 1, endTime.hour, endTime.minute);
      
      if (endTimeAsDateTime.isBefore(startTimeAsDateTime) || 
          endTimeAsDateTime.isAtSameMomentAs(startTimeAsDateTime)) {
        final newEndTime = startTimeAsDateTime.add(const Duration(hours: 1));
        ref.read(_selectedEndTimeProvider.notifier).state = TimeOfDay(
          hour: newEndTime.hour, 
          minute: newEndTime.minute,
        );
      }
    }
  }

  Future<void> _selectEndTime(BuildContext context, WidgetRef ref) async {
    final currentTime = ref.read(_selectedEndTimeProvider);
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    
    if (picked != null) {
      final startTime = ref.read(_selectedStartTimeProvider);
      final startTimeAsDateTime = DateTime(2024, 1, 1, startTime.hour, startTime.minute);
      final endTimeAsDateTime = DateTime(2024, 1, 1, picked.hour, picked.minute);
      
      if (endTimeAsDateTime.isAfter(startTimeAsDateTime)) {
        ref.read(_selectedEndTimeProvider.notifier).state = picked;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End time must be after start time'),
          ),
        );
      }
    }
  }

  Future<void> _createEvent(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController titleController,
    TextEditingController descriptionController,
    TextEditingController locationController,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final user = ref.read(currentUserProvider);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to create events')),
      );
      return;
    }

    ref.read(_createEventLoadingProvider.notifier).state = true;

    try {
      final selectedDate = ref.read(_selectedDateProvider);
      final startTime = ref.read(_selectedStartTimeProvider);
      final endTime = ref.read(_selectedEndTimeProvider);
      final eventType = ref.read(_selectedEventTypeProvider);

      final startDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        startTime.hour,
        startTime.minute,
      );

      final endDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        endTime.hour,
        endTime.minute,
      );

      final repository = ref.read(calendarRepositoryProvider);
      await repository.createEvent(
        title: titleController.text.trim(),
        description: descriptionController.text.trim().isEmpty 
            ? '' 
            : descriptionController.text.trim(),
        startDate: startDateTime,
        endDate: endDateTime,
        organizerId: user.id,
        location: locationController.text.trim().isEmpty ? null : locationController.text.trim(),
        status: EventStatus.pending,
      );

      // Refresh calendar events
      ref.invalidate(calendarEventsProvider);
      ref.invalidate(eventsForSelectedDateProvider);

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create event: $e')),
        );
      }
    } finally {
      ref.read(_createEventLoadingProvider.notifier).state = false;
    }
  }

  IconData _getEventTypeIcon(EventType type) {
    switch (type) {
      case EventType.photoshoot:
        return Icons.camera_alt;
      case EventType.videoshoot:
        return Icons.videocam;
      case EventType.meeting:
        return Icons.meeting_room;
      case EventType.consultation:
        return Icons.chat;
      case EventType.other:
        return Icons.event;
    }
  }

  Color _getEventTypeColor(EventType type) {
    switch (type) {
      case EventType.photoshoot:
        return Colors.blue;
      case EventType.videoshoot:
        return Colors.purple;
      case EventType.meeting:
        return Colors.green;
      case EventType.consultation:
        return Colors.orange;
      case EventType.other:
        return Colors.grey;
    }
  }

  String _formatEventType(EventType type) {
    switch (type) {
      case EventType.photoshoot:
        return 'Photo Shoot';
      case EventType.videoshoot:
        return 'Video Shoot';
      case EventType.meeting:
        return 'Meeting';
      case EventType.consultation:
        return 'Consultation';
      case EventType.other:
        return 'Other';
    }
  }
}

// Private providers for create event screen state
final _selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final _selectedStartTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final _selectedEndTimeProvider = StateProvider<TimeOfDay>((ref) {
  final now = TimeOfDay.now();
  return TimeOfDay(hour: (now.hour + 1) % 24, minute: now.minute);
});
final _selectedEventTypeProvider = StateProvider<EventType?>((ref) => null);
final _createEventLoadingProvider = StateProvider<bool>((ref) => false);