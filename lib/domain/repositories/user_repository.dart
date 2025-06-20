import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(int id);
}
