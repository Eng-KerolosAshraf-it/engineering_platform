import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/themes/app_theme.dart';
import 'core/state/language_state.dart';
import 'presentation/web/home_page.dart';
import 'presentation/web/civil_services_page.dart';
import 'presentation/web/service_selection_page.dart';
import 'presentation/web/auth/login_page.dart';
import 'presentation/web/auth/signup_page.dart';
import 'shared/widgets/main_layout.dart';

void main() async {
  // Initialize Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables from .env file
    await dotenv.load();

    // Initialize Supabase with credentials from .env
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!, // Supabase project URL
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!, // Supabase anonymous key
    );

    // Run the application
    runApp(const MyApp());
  } catch (error) {
    // Log connection error to console
    print('Connection Error: $error');

    // Fallback app that shows error message
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text('Connection Error: $error'))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, lang, child) {
        return MaterialApp(
          title: 'Engineering Platform',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          navigatorKey: navigatorKey,
          locale: Locale(lang),
          initialRoute: '/',
          routes: {
            '/': (context) => MainLayout(child: const HomePage()),
            '/login': (context) => const LoginPage(),
            '/signup': (context) => const SignupPage(),
            '/civil-services': (context) =>
                MainLayout(child: const CivilServicesPage()),
            '/services': (context) =>
                MainLayout(child: const ServiceSelectionPage()),
          },
        );
      },
    );
  }
}
