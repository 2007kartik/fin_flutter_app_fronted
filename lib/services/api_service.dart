import 'package:dio/dio.dart';
import 'api_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/signup_request.dart';
import '../constants/api_constants.dart';

class ApiService {
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
