import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/helpers/spacing.dart';
import 'package:tasky/feature/signup/logic/signup_cubit.dart';
import 'package:tasky/generated/assets.dart';
import '../../../../core/theming/styles.dart';

class FormSignup extends StatelessWidget {
   const FormSignup({super.key});

  @override
  Widget build(BuildContext context) {
    SignupCubit cubit= context.read<SignupCubit>();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Sign up',style: TextStyles.font24DarkerGrayBold,),
            verticalSpace(24),
            _nameTextFormField(cubit),
            verticalSpace(20),
            _phoneTextFormField(cubit,context),
            verticalSpace(20),
            _yearExperienceTextFormField(cubit),
            verticalSpace(20),
            _experienceLevelDropDown(cubit),
            verticalSpace(20),
            _addressTextFormField(cubit),
            verticalSpace(20),
            _passwordTextFormField(cubit),
            verticalSpace(24),
            _signUpButton(cubit),
            verticalSpace(24),
            _alreadyHaveText(cubit,context),
            verticalSpace(32),
          ],
        ),
      ),
    );
  }


   Widget _nameTextFormField(SignupCubit cubit){
     return TextFormField(
       controller: cubit.nameController,
       keyboardType: TextInputType.name,
       validator: (value){
         if(value.isNullOrEmpty()) {
           return 'Please enter a valid name';
         }
         return null;
       },

       decoration:  const InputDecoration(
         hintText: "Name...",
       ),

     );

   }
   Widget _phoneTextFormField(SignupCubit cubit,BuildContext context){
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
   Widget _yearExperienceTextFormField(SignupCubit cubit){
     return TextFormField(
       controller: cubit.yearExperienceController,
       keyboardType: TextInputType.number,
       validator: (value){
         if(value.isNullOrEmpty()) {
           return 'Please enter a valid Years of experience';
         }
         return null;
       },
       decoration:  const InputDecoration(
         hintText: "Years of experience...",
       ),

     );

   }
   Widget _experienceLevelDropDown(SignupCubit cubit){
     return DropdownButtonFormField<String>(
       value: cubit.selectedExperienceLevel,
       onChanged: (String? newValue)=>cubit.setSelectedExperienceLevel(newValue!),
       items:cubit.experienceLevels.map<DropdownMenuItem<String>>((String value) {
         return DropdownMenuItem<String>(
           value: value,
           child: Text(value),
         );
       }).toList(),
       decoration:  InputDecoration(
           hintText: 'Choose experience Level',
           hintStyle: TextStyles.font14DarkGrayBold
       ),
       validator: (value) {
         if (value == null || value.isEmpty) {
           return 'Please select experience level';
         }
         return null;
       },
     );
   }
   Widget _addressTextFormField(SignupCubit cubit){
     return TextFormField(
       controller: cubit.addressController,
       keyboardType: TextInputType.streetAddress,
       validator: (value){
         if(value.isNullOrEmpty()) {
           return 'Please enter a valid address';
         }
         return null;
       },
       decoration:  const InputDecoration(
         hintText: "Address...",
       ),

     );

   }
   Widget _passwordTextFormField(SignupCubit cubit){
     bool isObscureText = true;
     return StatefulBuilder(
       builder:(context, setState) =>  TextFormField(
         controller: cubit.passwordController,
         obscureText: isObscureText,
         validator: (value){
           if(value.isNullOrEmpty()) {
             return 'Please enter a valid password';
           }else if(value!.length<6){
             return "A password must be at least 8 characters long";

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
   Widget _signUpButton(SignupCubit cubit){
     return TextButton(onPressed: ()=>cubit.validate(), child: Text('Sign Up',style: TextStyles.font19WhiteBold,));
   }
   Widget _alreadyHaveText(SignupCubit cubit,BuildContext context){
     return Center(
       child: RichText(

         textAlign: TextAlign.center,
         text: TextSpan(
           children: [
             TextSpan(
               text: 'Already have any account?',
               style: TextStyles.font14GrayRegular,
             ),
             TextSpan(
               text: ' Sign in',
               style: TextStyles.font14MainColorBold.copyWith(decoration: TextDecoration.underline),
               recognizer: TapGestureRecognizer()
                 ..onTap = () {
                   context.pop();
                 },
             ),
           ],
         ),
       ),
     );
   }
}

