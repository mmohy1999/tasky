import 'package:tasky/core/models/task_model.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class HomeRepo {
  final ApiService _apiService;

  HomeRepo(this._apiService);

  Future<ApiResult<bool>> logout() async {
    try {
      final response = await _apiService.logout();
      return ApiResultSuccess(response);
    } catch (error) {
      return ApiResultFailure(error.toString());
    }
  }

  Future<ApiResult<List<Task>>> getTodos(int page) async {
    try {
      final response = await _apiService.getTasks(page.toString());
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