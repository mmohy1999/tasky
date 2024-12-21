import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/feature/signup/logic/signup_cubit.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import 'widgets/signup_screen_body.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (previous, current) => current is SignupLoading|| current is SignupSuccess || current is SignupError,
      listener: (context, state) {
        if(state is SignupLoading){
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor,
              ),
            ),
          );
        }else if(state is SignupSuccess){
          context.pushNamedAndRemoveUntil(Routes.homeScreen,predicate: (route) => false,);
        }else if(state is SignupError){
          setupErrorState(context, state.error);
        }
      },
      child: const SignupScreenBody(),
    );
  }
  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font14DarkGrayBold,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font19WhiteBold,
            ),
          ),
        ],
      ),
    );
  }

}
