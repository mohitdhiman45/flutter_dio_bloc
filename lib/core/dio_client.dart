import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }
}
