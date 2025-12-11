// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'core/constants/app_colors.dart';
// import 'features/registration/bloc/registration_bloc.dart';
// import 'features/registration/data/auth_repository.dart';
// import 'routes.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final repo = DummyAuthRepository();
//
//     return MultiBlocProvider(
//       providers: [BlocProvider(create: (_) => RegistrationBloc(repo))],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           scaffoldBackgroundColor: Colors.white,
//           fontFamily: 'Inter',
//           colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
//           useMaterial3: false,
//         ),
//         initialRoute: Routes.splash,
//         onGenerateRoute: AppRouter.generate,
//       ),
//     );
//   }
// }
