class Failure {
  const Failure(
    this.message, {
    this.aditionalData,
  });

  final String message;
  final Map<String, dynamic>? aditionalData;
}
