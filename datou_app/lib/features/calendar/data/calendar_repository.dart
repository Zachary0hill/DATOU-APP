import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/models.dart';
import 'calendar_models.dart';

class CalendarRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Availability?> getAvailability(DateTime date, String userId) async {
    try {
      final response = await _supabase
          .from('availability')
          .select('*')
          .eq('user_id', userId)
          .eq('date', date.toIso8601String().split('T')[0])
          .maybeSingle();

      if (response == null) return null;
      return Availability.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<List<Booking>> getBookingsForDate(DateTime date, String userId) async {
    try {
      final response = await _supabase
          .from('bookings')
          .select('*')
          .or('client_id.eq.$userId,provider_id.eq.$userId')
          .gte('start_date', date.toIso8601String().split('T')[0])
          .lt('start_date', DateTime(date.year, date.month, date.day + 1).toIso8601String().split('T')[0]);

      return response.map<Booking>((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Booking>> getBookingsForMonth(DateTime month, String userId) async {
    try {
      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = DateTime(month.year, month.month + 1, 0);

      final response = await _supabase
          .from('bookings')
          .select('*')
          .or('client_id.eq.$userId,provider_id.eq.$userId')
          .gte('start_date', startOfMonth.toIso8601String().split('T')[0])
          .lte('start_date', endOfMonth.toIso8601String().split('T')[0]);

      return response.map<Booking>((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Availability> setAvailability({
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required String userId,
    String? notes,
  }) async {
    final availabilityData = {
      'user_id': userId,
      'date': date.toIso8601String().split('T')[0],
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'is_available': true,
      'notes': notes,
      'updated_at': DateTime.now().toIso8601String(),
    };

    // Check if availability already exists for this date
    final existing = await getAvailability(date, userId);
    
    if (existing != null) {
      // Update existing availability
      final response = await _supabase
          .from('availability')
          .update(availabilityData)
          .eq('id', existing.id)
          .select()
          .single();
      
      return Availability.fromJson(response);
    } else {
      // Create new availability
      availabilityData['created_at'] = DateTime.now().toIso8601String();
      
      final response = await _supabase
          .from('availability')
          .insert(availabilityData)
          .select()
          .single();
      
      return Availability.fromJson(response);
    }
  }

  Future<void> removeAvailability(String availabilityId) async {
    await _supabase
        .from('availability')
        .delete()
        .eq('id', availabilityId);
  }

  Future<List<Availability>> getAvailabilityForMonth(DateTime month, String userId) async {
    try {
      final startOfMonth = DateTime(month.year, month.month, 1);
      final endOfMonth = DateTime(month.year, month.month + 1, 0);

      final response = await _supabase
          .from('availability')
          .select('*')
          .eq('user_id', userId)
          .gte('date', startOfMonth.toIso8601String().split('T')[0])
          .lte('date', endOfMonth.toIso8601String().split('T')[0]);

      return response.map<Availability>((json) => Availability.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Booking>> getBookingsForDateRange(DateTime startDate, DateTime endDate, String userId) async {
    try {
      final response = await _supabase
          .from('bookings')
          .select('*')
          .or('client_id.eq.$userId,provider_id.eq.$userId')
          .gte('start_date', startDate.toIso8601String())
          .lte('start_date', endDate.toIso8601String())
          .order('start_date', ascending: true);

      return response.map<Booking>((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Booking> createEvent({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String organizerId,
    String? location,
    EventStatus status = EventStatus.pending,
    List<String> participantIds = const [],
  }) async {
    final eventData = {
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'client_id': organizerId, // Using client_id as organizer
      'location': location,
      'status': status.name,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final response = await _supabase
        .from('bookings')
        .insert(eventData)
        .select()
        .single();

    return Booking.fromJson(response);
  }
}