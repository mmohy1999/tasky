import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/di/dependency_injection.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/networking/dio_factory.dart';
import 'package:tasky/tasky_app.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/helpers/shared_pref_keys.dart';
import 'core/routing/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
   await checkIfLoggedInUser();
  await ScreenUtil.ensureScreenSize();

  runApp( TaskyApp(appRouter: AppRouter(),));
}



checkIfLoggedInUser() async {
  String? userToken =
  await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);

  if (!userToken.isNullOrEmpty()) {
    SharedPrefKeys.isLoggedInUser = true;
    DioFactory.setTokenIntoHeaderAfterLogin(token: userToken);
  } else {
    SharedPrefKeys.isLoggedInUser = false;
  }
}
