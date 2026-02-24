import 'package:dio/dio.dart';
import 'package:login_application/core/network/api_client.dart';
import 'package:login_application/features/auth/data/models/login_response_model.dart';

import '../models/login_request_model.dart';

class AuthRemoteDatasource {
  final ApiClient apiClient;
  AuthRemoteDatasource(this.apiClient);

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final Response res = await apiClient.dio.post(
      '/api/login',
      data: request.toJson(),
    );
    return LoginResponseModel.fromJson(res.data as Map<String, dynamic>);
  }
}
