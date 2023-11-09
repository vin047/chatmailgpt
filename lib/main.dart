import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

import 'src/app.dart';

void main() async {
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  // await settingsController.loadSettings();

  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // ensure URL changes in the address bar when using push / pushNamed, as of GoRouter 8.0
  // more info here: https://docs.google.com/document/d/1VCuB85D5kYxPR3qYOjVmw8boAGKb7k62heFyfFHTOvw/edit
  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
