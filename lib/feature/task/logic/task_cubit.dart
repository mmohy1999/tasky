

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/models/task_model.dart';
import 'package:tasky/feature/task/data/repo/task_repo.dart';

part 'task_state.dart';

 String taskId='';
class TaskCubit extends Cubit<TaskState> {
  final TaskRepo _taskRepo;

  TaskCubit(this._taskRepo) : super(TaskInitial());
   late Task task;

  void getTask() async {
    emit(TaskLoading());
    final response = await _taskRepo.getTodo(taskId);
    response.when(
      success: (taskModel) {
        task=taskModel;
        emit(TaskSuccess(task));
      },
      failure: (error) {
        emit(TaskError(error: error));
      },
    );
  }

   emitDeleteStates() async{
     final response =await _taskRepo.deleteTask(task.id);
     response.when(success: (response) async{

       emit(DeleteTaskSuccess(response));
     }, failure: (error) {
       emit(DeleteTaskError(error: error));
     },);

   }
}
