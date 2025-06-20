import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network_checker.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repo;
  final NetworkChecker networkChecker;

  UserCubit(this.repo, this.networkChecker) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    final isConnected = await networkChecker.isConnected;

    try {
      final users = await repo.getUsers();
      emit(UserLoaded(users, isOffline: !isConnected));
    } catch (e) {
      emit(UserError('Failed to load users'));
    }
  }

  Future<void> addUser(User user) async {
    await repo.createUser(user);
    await fetchUsers();
  }

  Future<void> updateUser(User user) async {
    await repo.updateUser(user);
    await fetchUsers();
  }

  Future<void> deleteUser(int id) async {
    await repo.deleteUser(id);
    await fetchUsers();
  }
}
