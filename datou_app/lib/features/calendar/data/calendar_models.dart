import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_models.freezed.dart';
part 'calendar_models.g.dart';

enum CalendarEventType { availability, booking, blocked }

enum EventType { photoshoot, videoshoot, meeting, consultation, availability, booking, other }

enum EventStatus { pending, confirmed, cancelled, completed }

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String title,
    required CalendarEventType type,
    required DateTime startTime,
    required DateTime endTime,
    String? description,
    Object? data,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);
}

@freezed
class Availability with _$Availability {
  const factory Availability({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required DateTime date,
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') required DateTime endTime,
    @JsonKey(name: 'is_available') @Default(true) bool isAvailable,
    String? notes,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) => _$AvailabilityFromJson(json);
}