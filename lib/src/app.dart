import 'package:dingo_clean/src/screen/admin/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password1/forgot_password1_screen.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password2/forgot_password2_screen.dart';
import 'package:dingo_clean/src/screen/authentication/forgot_password/forgot_password3/forgot_password3_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_in/sign_in_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up/sign_up_screen.dart';
import 'package:dingo_clean/src/screen/authentication/sign_up2/sign_up2_screen.dart';
import 'package:dingo_clean/src/screen/authentication/verification_code/verification_code_screen.dart';
import 'package:dingo_clean/src/screen/splash/splash_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_1/booking_1_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_2/booking_2_screen.dart';
import 'package:dingo_clean/src/screen/user/booking_history/booking_history_screen.dart';
import 'package:dingo_clean/src/screen/user/change_language/change_language_screen.dart';
import 'package:dingo_clean/src/screen/user/change_password/change_password_screen.dart';
import 'package:dingo_clean/src/screen/user/homepage/components/homepage_screen.dart';
import 'package:dingo_clean/src/screen/user/my_profile/my_profile_screen.dart';
import 'package:dingo_clean/src/screen/user/payment/payment_screen.dart';
import 'package:dingo_clean/src/screen/user/receipt/receipt_screen.dart';
import 'package:dingo_clean/src/screen/user/setting/setting_screen.dart';
import 'package:dingo_clean/src/screen/user/update_profile/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'screen/admin/financial_service/financial_screen.dart';
import 'screen/admin/sign_in_admin/sign_in_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SignInScreen.routeName:
                    return const SignInScreen();
                  case SignInAdminScreen.routeName:
                    return const SignInAdminScreen();
                  case ForgotPassword1Screen.routeName:
                    return const ForgotPassword1Screen();
                  case ForgotPassword2Screen.routeName:
                    return const ForgotPassword2Screen();
                  case ForgotPassword3Screen.routeName:
                    return const ForgotPassword3Screen();
                  case SignUpPageScreen.routeName:
                    return const SignUpPageScreen();
                  case VerificationCodeScreen.routeName:
                    return const VerificationCodeScreen();
                  case SignUp2Screen.routeName:
                    return const SignUp2Screen();
                  case SettingScreen.routeName:
                    return const SettingScreen();
                  case ChangePasswordScreen.routeName:
                    return const ChangePasswordScreen();
                  case ChangeLanguageScreen.routeName:
                    return const ChangeLanguageScreen();
                  case MyProfileScreen.routeName:
                    return const MyProfileScreen();
                  case BookingHistoryScreen.routeName:
                    return const BookingHistoryScreen();
                  case Booking1Screen.routeName:
                    return Booking1Screen();
                  case Booking2Screen.routeName:
                    return const Booking2Screen();
                  case ReceiptScreen.routeName:
                    return const ReceiptScreen();
                  case HomepageScreen.routeName:
                    return const HomepageScreen();
                  case HomepageAdminScreen.routeName:
                    return const HomepageAdminScreen();

                  case FinancialServiceScreen.routeName:
                    return const FinancialServiceScreen();
                  case SplashScreen.routeName:
                  default:
                    return const SplashScreen();
                }
              },
            );
          },
        );
      },
    );
  }
}
