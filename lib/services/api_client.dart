import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'secure_storage_service.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 90), // Render free tier cold-start
      receiveTimeout: const Duration(seconds: 90), // Render free tier cold-start
      sendTimeout: const Duration(seconds: 90),
    ),
  );

  static Future<void> initialize() async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final storage = SecureStorageService();

          String? token = await storage.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";

            options.headers["Content-Type"] = "application/json";
          }

          handler.next(options);
        },
      ),
    );
  }
}
