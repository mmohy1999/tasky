
abstract class ApiResult<T> {
  const ApiResult();

  // Custom `when` function
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  });
}

class ApiResultSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiResultSuccess(this.data);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    return success(data);
  }
}

class ApiResultFailure<T> extends ApiResult<T> {
  final String errorHandler;

  const ApiResultFailure(this.errorHandler);

  @override
  R when<R>({
    required R Function(T data) success,
    required R Function(String errorHandler) failure,
  }) {
    return failure(errorHandler);
  }
}
