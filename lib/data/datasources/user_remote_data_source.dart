import 'package:dio/dio.dart';
import '../../core/dio_client.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final Dio _dio = DioClient().dio;

  Future<List<UserModel>> getUsers() async {
    final resp = await _dio.get('/users');
    return (resp.data as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
  }

  Future<void> createUser(UserModel u) =>
      _dio.post('/users', data: u.toJson());

  Future<void> updateUser(UserModel u) =>
      _dio.put('/users/${u.id}', data: u.toJson());

  Future<void> deleteUser(int id) => _dio.delete('/users/$id');
}
