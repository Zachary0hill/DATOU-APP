import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    return response;
  }

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future<AuthResponse> signInAnonymously() async {
    final response = await _client.auth.signInAnonymously();
    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  User? get currentUser => _client.auth.currentUser;

  Future<UserResponse> updateUserRole(UserRole role) async {
    final response = await _client.auth.updateUser(
      UserAttributes(
        data: {'role': role.name},
      ),
    );
    return response;
  }

  Future<UserResponse> updateUserMetadata(Map<String, dynamic> metadata) async {
    final response = await _client.auth.updateUser(
      UserAttributes(
        data: metadata,
      ),
    );
    return response;
  }

  Future<String> uploadAvatarBytes({required Uint8List bytes, required String userId}) async {
    final path = '$userId.jpg';
    await _client.storage
        .from('avatars')
        .uploadBinary(path, bytes, fileOptions: const FileOptions(contentType: 'image/jpeg', upsert: true));
    final url = _client.storage.from('avatars').getPublicUrl(path);
    return url;
  }

  UserRole? getUserRole() {
    final roleString = currentUser?.userMetadata?['role'] as String?;
    if (roleString == null) return null;
    
    return UserRole.values.firstWhere(
      (role) => role.name == roleString,
      orElse: () => UserRole.photographer,
    );
  }
}