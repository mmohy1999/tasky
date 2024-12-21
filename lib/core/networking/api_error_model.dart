
class ApiErrorModel {
  final String? message;
  final int? code;
  final Map<String, dynamic>? errors;

  ApiErrorModel({
    this.message,
    this.code,
    this.errors,
  });

  /// Factory constructor to parse JSON into an `ApiErrorModel` instance
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] as String?,
      code: json['code'] as int?,
      errors: json['data'] as Map<String, dynamic>?,
    );
  }

  /// Method to convert an `ApiErrorModel` instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'data': errors,
    };
  }
}
