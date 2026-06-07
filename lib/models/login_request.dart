class LoginRequest {
  final String upiId;
  final String password;

  LoginRequest({
    required this.upiId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'upiId': upiId,
      'password': password,
    };
  }
}
