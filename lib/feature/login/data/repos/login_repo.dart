


import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../models/login_request_body.dart';
import '../models/login_response.dart';

class LoginRepo {
  final ApiService _apiService;

  LoginRepo(this._apiService);

  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResultSuccess(response);
    } on Exception catch (error) {
      try {
        final response = await _apiService.login(loginRequestBody);
        return ApiResultSuccess(response);
      } on Exception catch (error) {
        final errorMessage = error.toString().replaceFirst('Exception: ', '');
        return ApiResultFailure(errorMessage);
      }
    }

  }
}