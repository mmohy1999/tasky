import 'package:tasky/feature/profile/data/models/profile_model.dart';

import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<ProfileModel>> getProfile() async {
    try {
      final response = await _apiService.getProfile();
      return ApiResultSuccess(response);
    } on Exception catch (error) {
      final errorMessage = error.toString().replaceFirst('Exception: ', '');
      return ApiResultFailure(errorMessage);
    }
  }
}