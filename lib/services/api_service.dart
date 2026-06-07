import 'package:dio/dio.dart';
import 'api_client.dart';
import '../models/set_pin_request.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/profile_response.dart';

import '../models/signup_request.dart';

class ApiService {
  Future<ProfileResponse?> getProfile() async {
    try {
      final response = await ApiClient.dio.get("/profile");

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> setPin(SetPinRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        "/auth/set-pin",
        data: request.toJson(),
      );

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      print("REQUEST:");
      print(request.toJson());

      final response = await ApiClient.dio.post(
        "/auth/login",
        data: request.toJson(),
      );

      print("STATUS CODE:");
      print(response.statusCode);

      print("RESPONSE:");
      print(response.data);

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("ERROR STATUS:");
      print(e.response?.statusCode);

      print("ERROR BODY:");
      print(e.response?.data);

      rethrow;
    }
  }

  Future<bool> signup(SignupRequest request) async {
    try {
      final response = await ApiClient.dio.post(
        "/auth/signup",
        data: request.toJson(),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
