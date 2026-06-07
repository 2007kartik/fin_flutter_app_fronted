class SignupRequest {
  final String upiId;
  final String name;
  final String password;
  final String pin;
  final String mobile;
  final String deviceId;

  SignupRequest({
    required this.upiId,
    required this.name,
    required this.password,
    required this.pin,
    required this.mobile,
    required this.deviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "upiId": upiId,
      "name": name,
      "password": password,
      "pin": pin,
      "mobile": mobile,
      "deviceId": deviceId,
    };
  }
}
