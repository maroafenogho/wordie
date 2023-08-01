class WordieUser {
  String email;
  String userId;
  String? fullName;
  bool emailVerified;

  WordieUser(
      {required this.email,
      required this.emailVerified,
      this.fullName,
      required this.userId});
}
