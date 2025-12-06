import 'package:flutter/material.dart';

import 'features/registration/ui/mobile_number_screen.dart';
import 'features/registration/ui/otp_screen.dart';
import 'features/registration/ui/personal_details_screen.dart';
import 'features/registration/ui/profile_type_screen.dart';
import 'features/registration/ui/religion_question_screen.dart';
import 'features/registration/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const mobileNumber = '/mobile';
  static const otp = '/otp';
  static const profileType = '/profile-type';
  static const personal = '/personal';
  static const religion = '/religion';
}

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.mobileNumber:
        return MaterialPageRoute(builder: (_) => const MobileNumberScreen());
      case Routes.otp:
        return MaterialPageRoute(builder: (_) => const OTPScreen());
      case Routes.profileType:
        return MaterialPageRoute(builder: (_) => const ProfileTypeScreen());
      case Routes.personal:
        return MaterialPageRoute(builder: (_) => const PersonalDetailsScreen());
      case Routes.religion:
        return MaterialPageRoute(
          builder: (_) => const ReligionQuestionScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
        );
    }
  }
}
