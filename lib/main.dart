import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dataLayer/cubit/app_cubit.dart';
import 'presentationLayer/screens/splash_screen.dart';
import 'core/utils/constansts.dart';
import 'core/utils/injection.dart'as di;
import 'core/utils/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (BuildContext context) => di.sl<AppBloc>(),
      child: MaterialApp(
         navigatorKey: navigatorKey,
         debugShowCheckedModeBanner: false,
        home:const SplashScreen(),
      ),
    );
  }
}