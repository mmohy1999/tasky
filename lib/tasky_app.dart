import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/helpers/shared_pref_keys.dart';
import 'core/helpers/app_navigator_key.dart';
import 'core/routing/app_router.dart';

import 'core/routing/routes.dart';
import 'core/theming/theme_app.dart';

class TaskyApp extends StatelessWidget {
  final AppRouter appRouter;

  const TaskyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasky',
        theme: appThemeData(),
        navigatorKey: AppNavigator.navigatorKey,
        initialRoute:SharedPrefKeys.isLoggedInUser?Routes.homeScreen:Routes.onBoardingScreen,
        onGenerateRoute: appRouter.generateRoute,
      ) ,
    );
  }


}


