import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';
import '../logic/calendar_providers.dart';
import '../data/calendar_models.dart';

class CalendarScreen extends HookConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = useState(DateTime.now());
    final focusedDay = useState(DateTime.now());
    final calendarFormat = useState(CalendarFormat.month);

    final availabilityAsync = ref.watch(availabilityProvider(selectedDay.value));
    final bookingsAsync = ref.watch(bookingsProvider(selectedDay.value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAvailabilityDialog(context, ref, selectedDay.value),
          ),
          PopupMenuButton<CalendarFormat>(
            icon: const Icon(Icons.view_module),
            onSelected: (format) => calendarFormat.value = format,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: CalendarFormat.month,
                child: Text('Month View'),
              ),
              PopupMenuItem(
                value: CalendarFormat.twoWeeks,
                child: Text('2 Weeks View'),
              ),
              PopupMenuItem(
                value: CalendarFormat.week,
                child: Text('Week View'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TableCalendar<CalendarEvent>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay.value,
              selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
              calendarFormat: calendarFormat.value,
              eventLoader: (day) => _getEventsForDay(day, ref),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedTextStyle: const TextStyle(color: Colors.white),
                selectedDecoration: const BoxDecoration(
                  color: kPrimary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: kPrimary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                markerDecoration: const BoxDecoration(
                  color: kSecondary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: kPrimary),
                rightChevronIcon: Icon(Icons.chevron_right, color: kPrimary),
              ),
              onDaySelected: (selectedDayParam, focusedDayParam) {
                selectedDay.value = selectedDayParam;
                focusedDay.value = focusedDayParam;
              },
              onFormatChanged: (format) => calendarFormat.value = format,
              onPageChanged: (focusedDayParam) => focusedDay.value = focusedDayParam,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, MMMM d, y').format(selectedDay.value),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAvailabilitySection(availabilityAsync, selectedDay.value),
                          const SizedBox(height: 16),
                          _buildBookingsSection(bookingsAsync),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAvailabilityDialog(context, ref, selectedDay.value),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<CalendarEvent> _getEventsForDay(DateTime day, WidgetRef ref) {
    final events = <CalendarEvent>[];
    
    // Add availability events
    final availability = ref.read(availabilityProvider(day));
    availability.whenData((avail) {
      if (avail != null) {
        events.add(CalendarEvent(
          title: 'Available',
          type: CalendarEventType.availability,
          startTime: avail.startTime,
          endTime: avail.endTime,
        ));
      }
    });

    // Add booking events
    final bookings = ref.read(bookingsProvider(day));
    bookings.whenData((bookingList) {
      for (final booking in bookingList) {
        events.add(CalendarEvent(
          title: 'Booking',
          type: CalendarEventType.booking,
          startTime: booking.startDate,
          endTime: booking.endDate,
          data: booking,
        ));
      }
    });

    return events;
  }

  Widget _buildAvailabilitySection(AsyncValue<Availability?> availabilityAsync, DateTime selectedDay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Availability',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextButton.icon(
              onPressed: () {}, // TODO: Edit availability
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Edit'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        availabilityAsync.when(
          data: (availability) {
            if (availability == null) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'No availability set for this day',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'Available ${DateFormat('HH:mm').format(availability.startTime)} - ${DateFormat('HH:mm').format(availability.endTime)}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildBookingsSection(AsyncValue<List<Booking>> bookingsAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bookings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        bookingsAsync.when(
          data: (bookings) {
            if (bookings.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.event_busy, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'No bookings for this day',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: bookings.map((booking) => _buildBookingCard(booking)).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }

  Widget _buildBookingCard(Booking booking) {
    Color statusColor;
    IconData statusIcon;
    
    switch (booking.status) {
      case BookingStatus.confirmed:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case BookingStatus.pending:
        statusColor = Colors.orange;
        statusIcon = Icons.schedule;
        break;
      case BookingStatus.completed:
        statusColor = Colors.blue;
        statusIcon = Icons.done_all;
        break;
      case BookingStatus.cancelled:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 20),
              const SizedBox(width: 8),
              Text(
                booking.status.name.toUpperCase(),
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '\$${booking.totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${DateFormat('HH:mm').format(booking.startDate)} - ${DateFormat('HH:mm').format(booking.endDate)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (booking.meetingLocation?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    booking.meetingLocation!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showAvailabilityDialog(BuildContext context, WidgetRef ref, DateTime selectedDay) {
    showDialog(
      context: context,
      builder: (context) => _AvailabilityDialog(selectedDay: selectedDay),
    );
  }
}

class _AvailabilityDialog extends HookConsumerWidget {
  const _AvailabilityDialog({required this.selectedDay});
  
  final DateTime selectedDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startTime = useState<TimeOfDay?>(null);
    final endTime = useState<TimeOfDay?>(null);

    return AlertDialog(
      title: Text('Set Availability - ${DateFormat('MMM d, y').format(selectedDay)}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) startTime.value = time;
                  },
                  child: Text(
                    startTime.value != null
                        ? startTime.value!.format(context)
                        : 'Start Time',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) endTime.value = time;
                  },
                  child: Text(
                    endTime.value != null
                        ? endTime.value!.format(context)
                        : 'End Time',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (startTime.value != null && endTime.value != null) {
              // TODO: Save availability
              ref.read(calendarProvider.notifier).setAvailability(
                selectedDay,
                startTime.value!,
                endTime.value!,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}