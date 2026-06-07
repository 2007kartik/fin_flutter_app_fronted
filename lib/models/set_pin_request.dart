class SetPinRequest {
  final String password;
  final String newPin;

  SetPinRequest({required this.password, required this.newPin});

  Map<String, dynamic> toJson() {
    return {"password": password, "newPin": newPin};
  }
}
