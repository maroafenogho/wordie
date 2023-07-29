class AppUser {
  String email;
  String userId;
  String? fullName;
  bool emailVerified;

  AppUser(
      {required this.email,
      required this.emailVerified,
      this.fullName,
      required this.userId});
}
