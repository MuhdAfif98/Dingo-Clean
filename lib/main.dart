import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51Ku7LCEj4onVUXNa9fdU57cK3tyZwShxcuWDBnSrB6AkzZJCU0mS6rBXmdgB3qhvCsSs6vf0kkoZlMqTUpgjXcO800iy86USRR";
  await Firebase.initializeApp();
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
