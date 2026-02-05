import 'package:supabase_flutter/supabase_flutter.dart';

/// Main service for Supabase database operations
/// Provides centralized access to Supabase client instance
class SupabaseService {
  /// Static accessor for Supabase client
  /// Use: SupabaseService.client.[operation]
  static SupabaseClient get client => Supabase.instance.client;
}