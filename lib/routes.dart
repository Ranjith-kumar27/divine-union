import 'package:divineunion_matrimony/features/main_screen.dart';
import 'package:flutter/material.dart';

import 'features/home/ui/home_screen.dart';
import 'features/registration/ui/mobile_number_screen.dart';
import 'features/registration/ui/otp_screen.dart';
import 'features/registration/ui/perfect_match_screen.dart';
import 'features/registration/ui/personal_details_screen.dart';
import 'features/registration/ui/profile_type_screen.dart';
import 'features/registration/ui/registration_success_screen.dart';
import 'features/registration/ui/religion_question_screen.dart';
import 'features/registration/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const perfectMatch = '/perfect-match';
  static const mobileNumber = '/mobile';
  static const otp = '/otp';
  static const profileType = '/profile-type';
  static const personal = '/personal';
  static const religion = '/religion';
  static const registrationSuccess = '/registration-success';
  static const home = '/home';
  static const main = '/main';
}

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.perfectMatch:
        return MaterialPageRoute(builder: (_) => const PerfectMatchScreen());
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
      case Routes.registrationSuccess:
        return MaterialPageRoute(
          builder: (_) => const RegistrationSuccessScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
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
