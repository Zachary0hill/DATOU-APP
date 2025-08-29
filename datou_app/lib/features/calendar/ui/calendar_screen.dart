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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Calendar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _showAvailabilityDialog(context, ref, selectedDay.value),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      PopupMenuButton<CalendarFormat>(
                        icon: const Icon(
                          Icons.view_module,
                          color: Colors.white,
                          size: 24,
                        ),
                        onSelected: (format) => calendarFormat.value = format,
                        color: Colors.grey[900],
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: CalendarFormat.month,
                            child: Text('Month View', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem(
                            value: CalendarFormat.twoWeeks,
                            child: Text('2 Weeks View', style: TextStyle(color: Colors.white)),
                          ),
                          const PopupMenuItem(
                            value: CalendarFormat.week,
                            child: Text('Week View', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Calendar Widget with proper sizing
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TableCalendar<CalendarEvent>(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay.value,
                selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
                calendarFormat: calendarFormat.value,
                eventLoader: (day) => _getEventsForDay(day, ref),
                startingDayOfWeek: StartingDayOfWeek.monday,
                rowHeight: 52,
                daysOfWeekHeight: 40,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  cellMargin: const EdgeInsets.all(4),
                  defaultTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  todayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: kPrimary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: kPrimary.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 3,
                  markerDecoration: BoxDecoration(
                    color: kSecondary,
                    shape: BoxShape.circle,
                  ),
                  markerSize: 6,
                  markerMargin: const EdgeInsets.symmetric(horizontal: 1),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: kPrimary, size: 24),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: kPrimary, size: 24),
                  headerPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onDaySelected: (selectedDayParam, focusedDayParam) {
                  selectedDay.value = selectedDayParam;
                  focusedDay.value = focusedDayParam;
                },
                onFormatChanged: (format) => calendarFormat.value = format,
                onPageChanged: (focusedDayParam) => focusedDay.value = focusedDayParam,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Selected Date Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                DateFormat('EEEE, MMMM d, y').format(selectedDay.value),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Content Section
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Padding(
                    // Ensure enough bottom space so content isn't hidden behind bottom nav
                    padding: const EdgeInsets.only(bottom: 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvailabilitySection(availabilityAsync, selectedDay.value),
                        const SizedBox(height: 24),
                        _buildBookingsSection(bookingsAsync),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FloatingActionButton(
          onPressed: () => _showAvailabilityDialog(context, ref, selectedDay.value),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white),
        ),
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: () {}, // TODO: Edit availability
              icon: const Icon(Icons.edit, size: 16, color: Color(0xFF8B5CF6)),
              label: const Text(
                'Edit',
                style: TextStyle(color: Color(0xFF8B5CF6), fontSize: 14),
              ),
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
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.white54, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'No availability set for this day',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Available ${DateFormat('HH:mm').format(availability.startTime)} - ${DateFormat('HH:mm').format(availability.endTime)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        bookingsAsync.when(
          data: (bookings) {
            if (bookings.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.event_busy, color: Colors.white54, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'No bookings for this day',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
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
          error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
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
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${DateFormat('HH:mm').format(booking.startDate)} - ${DateFormat('HH:mm').format(booking.endDate)}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          if (booking.meetingLocation?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    booking.meetingLocation!,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
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