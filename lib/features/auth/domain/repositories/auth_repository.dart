import '../../presentation/widgets/primary_button.dart';
import '../entities/login_response.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<(LoginResponse? data, Failure? failure)> login({
    required String email,
    required String password,
  });
}