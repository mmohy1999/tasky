import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky/core/helpers/extensions.dart';
import 'package:tasky/core/networking/api_constants.dart';
import 'package:tasky/core/routing/routes.dart';
import '../helpers/app_navigator_key.dart';
import '../helpers/shared_pref_helper.dart';
import '../helpers/shared_pref_keys.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();

      dio!
        ..options.baseUrl = ApiConstants.apiBaseUrl
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..interceptors.addAll([
          PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
          ),
        ]);

      addDioHeaders();
      setTokenIntoHeader();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken)}',
    };
    dio?.options.validateStatus = (status) {
      return status != null && status < 400;
    };
  }

  static void setTokenIntoHeaderAfterLogin({String? token}) {

      dio?.options.headers = {
        'Authorization': 'Bearer $token',
      };
      dio?.interceptors.add(TokenInterceptor());
  }
   static void setTokenIntoHeader()async {
     String token= await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);

     if(SharedPrefKeys.isLoggedInUser){
      dio?.options.headers = {
        'Authorization': 'Bearer $token',
      };
      dio?.interceptors.add(TokenInterceptor());
    }

  }
}

class TokenInterceptor extends Interceptor {
  bool isRefreshing = false; // Prevent multiple refresh calls
  final Dio _dio = DioFactory.getDio(); // A separate Dio instance for refreshing tokens

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !isRefreshing) {
      isRefreshing = true;
      try {
        await _refreshAccessToken();
        final options = err.requestOptions;
        final newAccessToken =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.accessToken);

        if (newAccessToken != null) {
          options.headers['Authorization'] = 'Bearer $newAccessToken';
        }

        final retryResponse = await _dio.fetch(options);
        handler.resolve(retryResponse);
      } catch (e) {
        print("Token refresh failed: $e");
        handler.reject(err);
      } finally {
        isRefreshing = false;
      }
    } else if (err.response?.statusCode == 403) {
      await SharedPrefHelper.clearSecuredData(SharedPrefKeys.accessToken);
      await SharedPrefHelper.clearSecuredData(SharedPrefKeys.refreshToken);

      final context = AppNavigator.navigatorKey.currentContext;
      if (context != null) {
        context.pushNamedAndRemoveUntil(
          Routes.loginScreen,
          predicate: (route) => false,
        );
      }
    } else {
      handler.next(err);
    }
  }


  Future<void> _refreshAccessToken() async {
    try {
      final refreshToken =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.refreshToken);

      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }

      // Call refresh token endpoint
      final response = await _dio.get(
        '${ApiConstants.refreshToken}?token=$refreshToken',

      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access_token'];

        // Update tokens in storage
        await SharedPrefHelper.setSecuredString(
            SharedPrefKeys.accessToken, newAccessToken);
        print('Access token refreshed successfully');
      } else {
        throw Exception('Failed to refresh access token');
      }
    } catch (e) {
      throw Exception('Error refreshing token: $e');
    }
  }
}
