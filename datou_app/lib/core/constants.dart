import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // Supabase Configuration
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? 'https://zkjgmoixxvmhtsnznrwp.supabase.co';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpramdtb2l4eHZtaHRzbnpucndwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyMTE5OTMsImV4cCI6MjA2Nzc4Nzk5M30.QvI1Vbyq402S47W3-PMr71ule9L5UYKrRqOXkNg9ndg';
  
  // Stripe Configuration
  static String get stripePublishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'pk_test_your-stripe-key';
  
  // App Information
  static String get appName => dotenv.env['APP_NAME'] ?? 'DATOU';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
}

enum UserRole {
  photographer,
  videographer,
  model,
  agency,
}

enum NavTab {
  home,
  listings,
  create,
  calendar,
  profile,
}