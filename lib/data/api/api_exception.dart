class ApiException implements Exception {
  final int statusCode;

  const ApiException(this.statusCode);
}
