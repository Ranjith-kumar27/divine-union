import 'package:divineunion_matrimony/services/verification_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/registration/bloc/registration_bloc.dart';
import 'features/registration/data/auth_repository.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if user is already verified
  final bool isVerified = await VerificationStorageService.isVerified();

  runApp(MyApp(isVerified: isVerified));
}

class MyApp extends StatelessWidget {
  final bool isVerified;

  const MyApp({super.key, required this.isVerified});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (context) => RegistrationBloc(ApiAuthRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Your App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        // Set initial route based on verification status
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouter.generate,
      ),
    );
  }
}
