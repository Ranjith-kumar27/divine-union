import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'features/registration/bloc/registration_bloc.dart';
import 'features/registration/data/auth_repository.dart';
import 'features/registration/data/master_data_repository.dart';
import 'services/verification_storage_service.dart';
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
          create: (context) => RegistrationBloc(
            repo: ApiAuthRepository(),
            masterDataRepo: MasterDataRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Divine Union',
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
