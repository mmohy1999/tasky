

import 'dart:io';
import 'package:tasky/core/models/task_model.dart';
import 'package:tasky/feature/add_task/data/models/edit_task_request_body.dart';
import 'package:tasky/feature/task/logic/task_cubit.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/add_task_request_body.dart';

class AddTaskRepo {
  final ApiService _apiService;

  AddTaskRepo(this._apiService);

  Future<ApiResult<Task>> addTask(
      AddTaskRequestBody addTaskRequestBody) async {
    try {
      final response = await _apiService.addTask(addTaskRequestBody);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }

  Future<ApiResult<Task>> editTask(
      EditTaskRequestBody editTaskRequestBody) async {
    try {
      final response = await _apiService.editTask(editTaskRequestBody);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }

  Future<ApiResult<String>> addImage(File file) async {
    try {
      final response = await _apiService.addImage(file);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }


  Future<ApiResult<Task>> getTodo(String id) async {
    try {
      final response = await _apiService.getTask(id);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }
}