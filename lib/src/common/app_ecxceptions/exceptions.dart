class WordieException implements Exception {
  final String message;
  final int? errorCode;

  WordieException({this.errorCode, required this.message});
}
