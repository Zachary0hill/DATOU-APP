import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? phoneNumber,
    required DateTime createdAt,
    DateTime? lastSignInAt,
    @JsonKey(name: 'user_metadata') Map<String, dynamic>? userMetadata,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}