import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/feature/signup/ui/widgets/form_singup.dart';
import '../../../../generated/assets.dart';


class SignupScreenBody extends StatelessWidget {
  const SignupScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 188.h,
                child: Image.asset(Assets.imagesImageSignup,fit: BoxFit.cover,),
              ),
              FormSignup()

            ],
            ),
          )

        )
    );
  }
}
