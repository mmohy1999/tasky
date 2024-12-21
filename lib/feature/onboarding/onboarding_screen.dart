import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/generated/assets.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/styles.dart';
import 'widgets/get_started_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child:
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(Assets.imagesImage,fit: BoxFit.cover,),
                )
            ),
            verticalSpace(24),
            Text(
              'Task Management &\nTo-Do List',
              style: TextStyles.font24DarkerGrayBold,
              textAlign: TextAlign.center,
            ),
            verticalSpace(16),
            Text("This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!",
              style: TextStyles.font14LightDarkGrayRegular.copyWith(height:1.71,),
              textAlign: TextAlign.center,),
            verticalSpace(32),
             Padding(
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 24.w),
              child: const GetStartedButton(),
            ),
            verticalSpace(74),
          ],
        ),
      ),
    );
  }
}
