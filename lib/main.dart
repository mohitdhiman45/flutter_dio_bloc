import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network_checker.dart';
import 'data/datasources/user_local_data_source.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'presentation/cubit/user_cubit.dart';
import 'presentation/pages/user_page.dart';

void main() {
  final local = UserLocalDataSource();
  final remote = UserRemoteDataSource();
  final repo = UserRepositoryImpl(remote, local);
  final checker = NetworkChecker();

  runApp(MyApp(repo: repo, checker: checker));
}

class MyApp extends StatelessWidget {
  final UserRepositoryImpl repo;
  final NetworkChecker checker;

  const MyApp({super.key, required this.repo, required this.checker});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Sync App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocProvider(
        create: (_) => UserCubit(repo, checker),
        child: const UserPage(),
      ),
    );
  }
}
