import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/network/api_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  final apiClient = ApiClient();
  final remote = AuthRemoteDatasource(apiClient);
  final repo = AuthRepositoryImpl(remote);
  final useCase = LoginUseCase(repo);
  const secureStorage = FlutterSecureStorage();

  runApp(MyApp(
    loginUseCase: useCase,
    secureStorage: secureStorage,
  ));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage secureStorage;

  const MyApp({
    super.key,
    required this.loginUseCase,
    required this.secureStorage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => LoginBloc(
          loginUseCase: loginUseCase,
          secureStorage: secureStorage,
        ),
        child: const LoginPage(),
      ),
    );
  }
}