import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/helpers/spacing.dart';
import 'package:tasky/core/routing/app_router.dart';
import 'package:tasky/feature/login/logic/login_cubit.dart';
import 'package:tasky/generated/assets.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';

class FormLogin extends StatelessWidget {
   const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit= context.read<LoginCubit>();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login',style: TextStyles.font24DarkerGrayBold,),
            verticalSpace(24),
            _phoneTextFormField(cubit,context),
            verticalSpace(20),
            _passwordTextFormField(cubit),
            verticalSpace(24),
            signInButton(cubit),
            verticalSpace(24),
            doNotHaveText(context),
            verticalSpace(32),

          ],
        ),
      ),
    );
  }


   Widget _phoneTextFormField(LoginCubit cubit,BuildContext context){
     return PhoneFormField(
       controller: cubit.phoneController,
       decoration:  const InputDecoration(
         hintText: '123 456-7890',
       ),
       validator: PhoneValidator.compose(
           [PhoneValidator.required(context), PhoneValidator.validMobile(context)]),
       autovalidateMode: AutovalidateMode.disabled,
       countryButtonStyle:  CountryButtonStyle(
           textStyle: TextStyles.font14GrayBold,
           flagSize: 24.sp
       ),

     );
   }
   Widget _passwordTextFormField(LoginCubit cubit){
     bool isObscureText = true;
     return StatefulBuilder(
       builder:(context, setState) =>  TextFormField(
         controller: cubit.passwordController,
         obscureText: isObscureText,
         validator: (value){
           if(value.isNullOrEmpty()) {
             return 'Please enter a valid password';
           }
           return null;
         },

         decoration:  InputDecoration(
           hintText: "Password...",
           suffixIcon: Padding(
             padding:  EdgeInsetsDirectional.only(end: 17.w),
             child: IconButton(onPressed:() {
               setState(() {
                 isObscureText= !isObscureText;
               },
               );
             }, icon: SvgPicture.asset(Assets.iconsEye)),
           ),

         ),

       ),
     );
   }
   Widget signInButton(LoginCubit cubit){
     return TextButton(onPressed:() => cubit.validateThenDoLogin(), child: Text('Sign In',style: TextStyles.font19WhiteBold,));
   }
   Widget doNotHaveText(BuildContext context){
     return Center(
       child: RichText(

         textAlign: TextAlign.center,
         text: TextSpan(
           children: [
             TextSpan(
               text: 'Didn\’t have any account?',
               style: TextStyles.font14GrayRegular,
             ),
             TextSpan(
               text: ' Sign Up here',
               style: TextStyles.font14MainColorBold.copyWith(decoration: TextDecoration.underline),
               recognizer: TapGestureRecognizer()
                 ..onTap = () {
                   context.pushNamed(Routes.signUpScreen);
                 },
             ),
           ],
         ),
       ),
     );
   }
}

