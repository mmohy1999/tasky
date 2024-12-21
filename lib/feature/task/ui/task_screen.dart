import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/routing/routes.dart';

import '../../../core/theming/colors.dart';
import '../logic/task_cubit.dart';
import 'widgets/task_screen_body.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      buildWhen: (previous, current) =>  current is TaskLoading || current is TaskSuccess || current is TaskError,
      builder: (context, state) {
        if(state is TaskLoading){
          return Scaffold(body: Center(child: CircularProgressIndicator(color: ColorsManager.mainColor,),),);
        }
        else if(state is TaskError){
          return Scaffold(body: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              Text(state.error),
            ],
          ),),);
        }else if(state is TaskSuccess) {
          return TaskScreenBody();
        }
        return Scaffold();
      },
      listenWhen: (previous, current) => current is DeleteTaskError ||current is DeleteTaskSuccess,
      listener: (BuildContext context,  state) {
        if(state is DeleteTaskSuccess){
          context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (route) => false,);
        }else if(state is DeleteTaskError){
          print(state.error);
        }
      },


    );
  }
}
