import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/models/models.dart';
import '../../auth/logic/auth_providers.dart';
import '../data/calendar_models.dart';
import '../data/calendar_repository.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository();
});

final availabilityProvider = FutureProvider.family<Availability?, DateTime>((ref, date) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return null;
  
  return repository.getAvailability(date, userId);
});

final bookingsProvider = FutureProvider.family<List<Booking>, DateTime>((ref, date) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return [];
  
  return repository.getBookingsForDate(date, userId);
});

final monthlyBookingsProvider = FutureProvider.family<List<Booking>, DateTime>((ref, month) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return [];
  
  return repository.getBookingsForMonth(month, userId);
});

final monthlyAvailabilityProvider = FutureProvider.family<List<Availability>, DateTime>((ref, month) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return [];
  
  return repository.getAvailabilityForMonth(month, userId);
});

final calendarProvider = StateNotifierProvider<CalendarNotifier, AsyncValue<void>>((ref) {
  return CalendarNotifier(ref);
});

class CalendarNotifier extends StateNotifier<AsyncValue<void>> {
  CalendarNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> setAvailability(DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(calendarRepositoryProvider);
      final userId = ref.read(currentUserProvider)?.id;
      
      if (userId == null) throw Exception('User not logged in');
      
      final startDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        startTime.hour,
        startTime.minute,
      );
      
      final endDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        endTime.hour,
        endTime.minute,
      );
      
      await repository.setAvailability(
        date: date,
        startTime: startDateTime,
        endTime: endDateTime,
        userId: userId,
      );
      
      // Refresh the availability for this date
      ref.invalidate(availabilityProvider(date));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeAvailability(String availabilityId, DateTime date) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = ref.read(calendarRepositoryProvider);
      await repository.removeAvailability(availabilityId);
      
      // Refresh the availability for this date
      ref.invalidate(availabilityProvider(date));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Missing providers referenced in other parts of the app
final upcomingEventsProvider = FutureProvider<List<Booking>>((ref) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return [];
  
  final now = DateTime.now();
  final endDate = now.add(const Duration(days: 7)); // Next 7 days
  
  return repository.getBookingsForDateRange(now, endDate, userId);
});

final calendarEventsProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final repository = ref.read(calendarRepositoryProvider);
  final userId = ref.read(currentUserProvider)?.id;
  
  if (userId == null) return [];
  
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 0);
  
  // Get bookings and availability for the current month
  final bookings = await repository.getBookingsForDateRange(startOfMonth, endOfMonth, userId);
  final availability = await repository.getAvailabilityForMonth(startOfMonth, userId);
  
  // Convert to CalendarEvents
  final events = <CalendarEvent>[];
  
  // Add booking events
  for (final booking in bookings) {
    events.add(CalendarEvent(
      title: 'Booking: ${booking.listingId}', // Using listingId as title fallback
      type: CalendarEventType.booking,
      startTime: booking.startDate,
      endTime: booking.endDate,
      description: booking.specialInstructions,
      data: booking,
    ));
  }
  
  // Add availability events
  for (final avail in availability) {
    events.add(CalendarEvent(
      title: 'Available',
      type: CalendarEventType.availability,
      startTime: avail.startTime,
      endTime: avail.endTime,
      description: avail.notes,
      data: avail,
    ));
  }
  
  return events;
});

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final eventsForSelectedDateProvider = Provider<List<CalendarEvent>>((ref) {
  final selectedDate = ref.watch(selectedDateProvider);
  final allEvents = ref.watch(calendarEventsProvider).valueOrNull ?? [];
  
  return allEvents.where((event) {
    return event.startTime.year == selectedDate.year &&
           event.startTime.month == selectedDate.month &&
           event.startTime.day == selectedDate.day;
  }).toList();
});

// Private providers for create event screen
final _selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final _selectedStartTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
final _selectedEndTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1));
final _selectedEventTypeProvider = StateProvider<EventType>((ref) => EventType.photoshoot);
final _createEventLoadingProvider = StateProvider<bool>((ref) => false);