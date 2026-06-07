class LoginResponse {
  final String token;
  final String mobile;
  final String message;

  LoginResponse({
    required this.token,
    required this.mobile,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      mobile: json['mobile'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
