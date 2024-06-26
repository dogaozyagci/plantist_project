class BaseResult<T> {
  final bool success;
  final String message;
  final T data;

  BaseResult(
      {required this.success, required this.message, required this.data});
}
