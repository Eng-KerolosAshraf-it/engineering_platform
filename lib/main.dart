import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables from .env file
    await dotenv.load();

    // Initialize Supabase with credentials from .env
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,      // Supabase project URL
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!, // Supabase anonymous key
    );

    // Run the application
    runApp(const MyApp());
    
  } catch (error) {
    // Log connection error to console
    print('Connection Error: $error');
    
    // Fallback app that shows error message
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Connection Error: $error'),
        ),
      ),
    ));
  }
}

