import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<(LoginResponse? data, Failure? failure)> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remote.login(
        LoginRequestModel(email: email, password: password),
      );

      print('✅ LOGIN SUCCESS — TOKEN: ${model.token}');

      return (LoginResponse(token: model.token), null);

    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      return (null, Failure("Login failed ($status): ${data ?? e.message}"));
    } catch (e) {
      return (null, Failure("Login failed: $e"));
    }
  }
}