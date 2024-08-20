import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_academy/ui/screens/splash/splash_screen.dart';

import 'core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(350, 800),
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.mainBackground
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }
    );
  }
}
