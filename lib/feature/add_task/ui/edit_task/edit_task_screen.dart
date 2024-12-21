import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/theming/colors.dart';
import 'package:tasky/feature/add_task/ui/add_task/add_task_body_screen.dart';
import 'package:tasky/feature/add_task/ui/edit_task/edit_task_body_screen.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../task/logic/task_cubit.dart';
import '../../logic/add_task_cubit.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listenWhen: (previous, current) => current is EditTaskLoading||current is EditTaskSuccess || current is EditTaskError,
      listener: (context, state) {
        if(state is EditTaskLoading){
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor,
              ),
            ),
          );
        }

        else if(state is EditTaskSuccess){
          context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (route) => false,);

        }else if(state is EditTaskError){
          setupErrorState(context, state.error);
        }

      },

      buildWhen: (previous, current) => current is GetTaskLoading||current is GetTaskSuccess||current is GetTaskError,
      builder: (context, state) {
        if(state is GetTaskLoading){
          return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,),),);
        }
        else if(state is GetTaskError){
          return Scaffold(body: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              Text(state.error),
            ],
          ),),);
        }else if(state is GetTaskSuccess) {
          return EditTaskBodyScreen();
        }else if(state is GetTaskError){
          return Scaffold(
            body: Column(
              children: [
                Text('Error'),
                Text(state.error),

              ],
            ),
          );
        }

        return Scaffold();
      },
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
