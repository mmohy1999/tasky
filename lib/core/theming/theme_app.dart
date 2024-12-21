import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/core/theming/styles.dart';

import 'colors.dart';

ThemeData appThemeData(){
return ThemeData(
    primaryColor: ColorsManager.mainColor,
    scaffoldBackgroundColor:Colors.white,
    textButtonTheme: _textButtonThemeData() ,
  inputDecorationTheme:_inputDecorationTheme(),

);
}

TextButtonThemeData _textButtonThemeData(){
  return TextButtonThemeData(style:  ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(ColorsManager.mainColor),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fixedSize:WidgetStateProperty.all(
      Size(double.maxFinite,50.h),
    ) ,
    padding:  WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 14.h , horizontal: 12.w)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ));
}

InputDecorationTheme _inputDecorationTheme(){
  return InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
    hintStyle: TextStyles.font14GrayRegular.copyWith(letterSpacing: 0.2.w,height: 1.4),
    focusedBorder:OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorsManager.mainColor,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorsManager.lightGray,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

