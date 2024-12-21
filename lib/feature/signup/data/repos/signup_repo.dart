import 'package:tasky/feature/signup/data/models/signup_response.dart';


import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/helpers/shared_pref_keys.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/dio_factory.dart';
import '../models/signup_request_body.dart';


class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    try {
      final response = await _apiService.signup(signupRequestBody);
      await saveUserToken(response.accessToken!, response.refreshToken!, response.id!);
      return ApiResultSuccess(response);
    } on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }

  Future<void> saveUserToken(String accessToken,String refreshToken, String id ) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.accessToken, accessToken);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, id);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.refreshToken, refreshToken);

    DioFactory.setTokenIntoHeaderAfterLogin(token: accessToken);
  }
}