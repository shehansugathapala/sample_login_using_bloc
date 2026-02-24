import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final FlutterSecureStorage secureStorage;

  LoginBloc({
    required this.loginUseCase,
    required this.secureStorage,
  }) : super(LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    // validation
    if (!event.email.contains('@')) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Invalid email address.',
      ));
      return;
    }
    if (event.password.length < 6) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Password must be at least 6 characters.',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, errorMessage: ''));

    final (data, failure) = await loginUseCase(
      email: event.email,
      password: event.password,
    );

    if (failure != null) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: failure.message,
      ));
      return;
    }

    final token = data?.token ?? '';
    if (event.rememberMe) {
      await secureStorage.write(key: 'token', value: token);
    }

    emit(state.copyWith(status: LoginStatus.success, token: token));
  }
}