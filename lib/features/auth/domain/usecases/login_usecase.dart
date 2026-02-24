import 'package:login_application/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failures.dart';
import '../../presentation/widgets/primary_button.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<(LoginResponse? data, Failure? failure)> call({
    required String email,
    required String password,
  }) {
    return repo.login(email: email, password: password);
  }
}