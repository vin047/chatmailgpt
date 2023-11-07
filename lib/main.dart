import 'package:flutter/material.dart';

import 'src/app.dart';

void main() async {
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // await settingsController.loadSettings();

  runApp(
      child: const MyApp(),
  );
}
