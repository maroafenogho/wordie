class User {
  String email;
  String userId;
  String? fullName;
  bool emailVerified;

  User(
      {required this.email,
      required this.emailVerified,
      this.fullName,
      required this.userId});
}
