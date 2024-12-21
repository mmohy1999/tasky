import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/theming/colors.dart';
import 'package:tasky/feature/add_task/ui/add_task/add_task_body_screen.dart';
import 'package:tasky/feature/task/logic/task_cubit.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/add_task_cubit.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTaskCubit, AddTaskState>(
      listenWhen: (previous, current) => current is AddTaskLoading || current is AddTaskSuccess || current is AddTaskError ||current is SetImageTaskError,
      listener: (context, state) {
        if(state is AddTaskLoading){
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainColor,
              ),
            ),
          );
        }
        else if(state is AddTaskSuccess){
          taskId=state.data.id;
          context.pop();
          context.pushReplacementNamed(Routes.taskScreen);
        }else if(state is AddTaskError){
          setupErrorState(context, state.error);
        }else if(state is SetImageTaskError){
          setupErrorState(context, state.error);
        }

      },
      child: const AddTaskBodyScreen(),
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
