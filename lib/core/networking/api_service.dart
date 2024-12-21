import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:tasky/feature/add_task/data/models/add_task_request_body.dart';
import 'package:tasky/core/models/task_model.dart';
import 'package:tasky/feature/add_task/logic/add_task_cubit.dart';
import 'package:tasky/feature/profile/data/models/profile_model.dart';
import '../../feature/add_task/data/models/edit_task_request_body.dart';
import '../../feature/login/data/models/login_request_body.dart';
import '../../feature/login/data/models/login_response.dart';
import '../../feature/signup/data/models/signup_request_body.dart';
import '../../feature/signup/data/models/signup_response.dart';
import '../helpers/shared_pref_helper.dart';
import '../helpers/shared_pref_keys.dart';
import 'api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// Login API
  Future<LoginResponse> login(LoginRequestBody loginRequestBody) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: {
          'phone': loginRequestBody.phone,
          'password': loginRequestBody.password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        throw Exception('Failed to login: ${response.data['message']}');
      } else {
        throw Exception('Failed to login: ${response.data['message']}');
      }
    }on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }

  }
  /// Signup API
  Future<SignupResponse> signup(SignupRequestBody signupRequestBody) async {
    try {
      final response = await _dio.post(
        ApiConstants.signup,
        data:signupRequestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SignupResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  ///profile API
  Future<ProfileModel> getProfile() async {
    try {
      final response = await _dio.get(ApiConstants.profile);

      if (response.statusCode == 200) {
        ProfileModel profile = ProfileModel.fromJson(response.data);

        return profile;
      } else {
        throw Exception('Failed to fetch todo: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

  ///Logout API
  Future<bool> logout() async {
    try {
      final response = await _dio.post(
        ApiConstants.logout,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }



  ///  Tasks APIs
  Future<List<Task>> getTasks(String page) async {
    try {
      final response = await _dio.get('${ApiConstants.todos}?page=$page');

      if (response.statusCode == 200) {
        List<Task> todos = [];
        for (var x in response.data) {
          todos.add(Task.fromJson(x));
        }
        return todos;
      } else {
        throw Exception('Failed to fetch todos: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
  Future<Task> getTask(String id) async {
    try {
      final response = await _dio.get(ApiConstants.todos + id);

      if (response.statusCode == 200) {
        Task todo = Task.fromJson(response.data);

        return todo;
      } else {
        throw Exception('Failed to fetch todo: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
  Future<Task> deleteTask(String id) async {
    try {
      final response = await _dio.delete(ApiConstants.todos + id);

      if (response.statusCode == 200||response.statusCode == 201) {
        Task todo = Task.fromJson(response.data);

        return todo;
      } else {
        throw Exception('Failed to fetch todo: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
  Future<Task> addTask(AddTaskRequestBody addTaskRequestBody) async {
    try {
      final response = await _dio.post(
        ApiConstants.todos,
        data: addTaskRequestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Task.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }
  Future<Task> editTask(EditTaskRequestBody editTaskRequestBody) async {
    try {
      final response = await _dio.put(
        ApiConstants.todos+editTaskId,
        data: editTaskRequestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Task.fromJson(response.data);
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }



  Future<String> addImage(File file) async {
    try {
      print("Uploading file: ${file.uri.pathSegments.last}");

      // Get the access token
      String accessToken = await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);

      // Determine the MIME type of the file
      String? mimeType = lookupMimeType(file.path) ?? 'image/jpeg';

      // Prepare the form data
      var data = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
          contentType: MediaType.parse(mimeType), // Explicit MIME type
        ),
      });

      // Make the POST request
      var response = await _dio.post(
        ApiConstants.uploadImage,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: data,
      );

      print("Response status code: ${response.statusCode}");

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['image'].toString();

      } else {
        throw Exception('Failed to upload image. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message;
      throw Exception(errorMessage);
    }
  }

}
