import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../logic/login_cubit.dart';
import 'widgets/login_screen_body.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => current is LoginLoading || current is LoginSuccess || current is LoginError,
      listener: (context, state) {
        if(state is LoginLoading){
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor,
              ),
            ),
          );
        }else if(state is LoginSuccess){
          context.pushNamedAndRemoveUntil(Routes.homeScreen,predicate: (route) => false,);
          //context.pushNamedAndRemoveUntil(Routes.addTaskScreen,predicate: (route) => false,);
        }else if(state is LoginError){
          setupErrorState(context, state.error);
        }

      },
      child: const LoginScreenBody(),
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
