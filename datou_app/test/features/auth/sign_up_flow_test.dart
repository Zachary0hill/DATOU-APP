import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:datou_app/main.dart';
import 'package:datou_app/core/constants.dart';
import 'package:datou_app/features/auth/data/auth_repository.dart';
import 'package:datou_app/features/auth/logic/auth_providers.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}
class MockAuthResponse extends Mock implements AuthResponse {}
class MockUserResponse extends Mock implements UserResponse {}
class MockUser extends Mock implements User {}
class MockSession extends Mock implements Session {}

void main() {
  group('Sign Up Flow Tests', () {
    late MockSupabaseClient mockSupabaseClient;
    late MockGoTrueClient mockAuth;

    setUpAll(() async {
      // Initialize Supabase for testing
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        anonKey: AppConstants.supabaseAnonKey,
      );
    });

    setUp(() {
      mockSupabaseClient = MockSupabaseClient();
      mockAuth = MockGoTrueClient();
      
      when(() => mockSupabaseClient.auth).thenReturn(mockAuth);
    });

    testWidgets('Complete sign-up to home flow', (WidgetTester tester) async {
      // Mock successful sign up
      final mockUser = MockUser();
      final mockSession = MockSession();
      final mockAuthResponse = MockAuthResponse();
      
      when(() => mockUser.userMetadata).thenReturn({'name': 'Test User'});
      when(() => mockUser.email).thenReturn('test@example.com');
      when(() => mockUser.isAnonymous).thenReturn(false);
      when(() => mockSession.user).thenReturn(mockUser);
      when(() => mockAuthResponse.user).thenReturn(mockUser);
      when(() => mockAuthResponse.session).thenReturn(mockSession);
      
      when(() => mockAuth.signUp(
        email: any(named: 'email'),
        password: any(named: 'password'),
        data: any(named: 'data'),
      )).thenAnswer((_) async => mockAuthResponse);

      when(() => mockAuth.onAuthStateChange).thenAnswer(
        (_) => Stream.value(AuthState(AuthChangeEvent.signedIn, mockSession)),
      );

      when(() => mockAuth.currentUser).thenReturn(mockUser);

      // Mock role update
      final mockUserResponse = MockUserResponse();
      when(() => mockUserResponse.user).thenReturn(mockUser);
      when(() => mockAuth.updateUser(any())).thenAnswer((_) async => mockUserResponse);

      // Create app with mocked auth repository
      final app = ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => AuthRepository()),
        ],
        child: const DatouApp(),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Verify we start at sign up screen
      expect(find.text('Welcome to DATOU'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);

      // Fill in sign up form
      await tester.enterText(find.byType(TextField).at(0), 'Test User');
      await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(2), 'password123');

      // Tap Sign Up button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Should navigate to role selection
      expect(find.text('Choose Your Role'), findsOneWidget);
      expect(find.text('Photographer'), findsOneWidget);
      expect(find.text('Videographer'), findsOneWidget);
      expect(find.text('Model'), findsOneWidget);
      expect(find.text('Agency'), findsOneWidget);

      // Select photographer role
      await tester.tap(find.text('Photographer'));
      await tester.pumpAndSettle();

      // Tap Continue button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));
      await tester.pumpAndSettle();

      // Should navigate to main scaffold with home screen
      expect(find.text('DATOU'), findsOneWidget);
      expect(find.text('Home Feed'), findsOneWidget);
      
      // Verify bottom navigation is present
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Listings'), findsOneWidget);
      expect(find.text('Create'), findsOneWidget);
      expect(find.text('Calendar'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Navigation between tabs works', (WidgetTester tester) async {
      // Mock authenticated user with role
      final mockUser = MockUser();
      final mockSession = MockSession();
      
      when(() => mockUser.userMetadata).thenReturn({'name': 'Test User', 'role': 'photographer'});
      when(() => mockUser.email).thenReturn('test@example.com');
      when(() => mockUser.isAnonymous).thenReturn(false);
      when(() => mockSession.user).thenReturn(mockUser);
      
      when(() => mockAuth.onAuthStateChange).thenAnswer(
        (_) => Stream.value(AuthState(AuthChangeEvent.signedIn, mockSession)),
      );
      when(() => mockAuth.currentUser).thenReturn(mockUser);

      final app = ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWith((ref) => AuthRepository()),
        ],
        child: const DatouApp(),
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Should start at home
      expect(find.text('Home Feed'), findsOneWidget);

      // Tap Listings tab
      await tester.tap(find.text('Listings'));
      await tester.pumpAndSettle();
      expect(find.text('Listings'), findsOneWidget);

      // Tap Profile tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile'), findsOneWidget);
    });
  });
}