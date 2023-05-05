class ApiError extends Error {
  final String message;
  final int code;

  ApiError({required this.message, required this.code});

  @override
  String toString() {
    return 'ApiError: $message (code: $code)';
  }
}
