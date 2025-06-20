import '../../domain/entities/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool isOffline;

  UserLoaded(this.users, {this.isOffline = false});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
