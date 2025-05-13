class UserLoginModel {
  final String login;
  final String password;
  String accessToken = '';

  UserLoginModel({
    required this.login,
    required this.password,
  });
}
