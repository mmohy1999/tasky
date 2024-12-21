import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/feature/login/ui/widgets/form_login.dart';
import '../../../../generated/assets.dart';
import '../../../signup/ui/widgets/form_singup.dart';


class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
            children: [

              SizedBox(
                width: double.infinity,
                height: 438.h,
                child: Image.asset(Assets.imagesImage,fit: BoxFit.cover,),
              ),
              FormLogin(),

            ],
            ),
          )

        )
    );
  }
}
