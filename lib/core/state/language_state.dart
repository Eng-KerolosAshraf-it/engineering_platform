import 'package:flutter/material.dart';

final languageNotifier = ValueNotifier<String>('ar');

// Global Navigation Key to handle navigation from inside the builder
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
