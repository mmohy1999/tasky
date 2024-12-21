import 'package:tasky/core/models/task_model.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class TaskRepo {
  final ApiService _apiService;

  TaskRepo(this._apiService);

  Future<ApiResult<Task>> getTodo(String id) async {
    try {
      final response = await _apiService.getTask(id);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }

  Future<ApiResult<Task>> deleteTask(String id) async {
    try {
      final response = await _apiService.deleteTask(id);
      return ApiResultSuccess(response);
    }on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }
}