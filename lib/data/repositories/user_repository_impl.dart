import '../../data/datasources/user_remote_data_source.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  final UserLocalDataSource local;

  UserRepositoryImpl(this.remote, this.local);

  @override
  Future<List<User>> getUsers() async {
    try {
      final r = await remote.getUsers();
      await local.cacheUsers(r);
      return r;
    } catch (_) {
      final l = await local.getCachedUsers();
      return l;
    }
  }

  @override
  Future<void> createUser(User u) async {
    final m = UserModel(id: u.id, name: u.name, email: u.email);
    await remote.createUser(m);
    await local.insertUser(m);
  }

  @override
  Future<void> updateUser(User u) async {
    final m = UserModel(id: u.id, name: u.name, email: u.email);
    await remote.updateUser(m);
    await local.updateUser(m);
  }

  @override
  Future<void> deleteUser(int id) async {
    await remote.deleteUser(id);
    await local.deleteUser(id);
  }
}
