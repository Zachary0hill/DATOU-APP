// This is a basic Flutter widget test for DATOU app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:datou_app/main.dart';
import 'package:datou_app/core/constants.dart';

void main() {
  setUpAll(() async {
    // Initialize Supabase for testing
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  });

  testWidgets('App launches and shows sign up screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: DatouApp(),
      ),
    );

    // Wait for the app to fully load
    await tester.pumpAndSettle();

    // Verify that our app shows the welcome screen
    expect(find.text('Welcome to DATOU'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
  });
}