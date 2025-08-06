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

  UserRole? getUserRole() {
    final roleString = currentUser?.userMetadata?['role'] as String?;
    if (roleString == null) return null;
    
    return UserRole.values.firstWhere(
      (role) => role.name == roleString,
      orElse: () => UserRole.photographer,
    );
  }
}