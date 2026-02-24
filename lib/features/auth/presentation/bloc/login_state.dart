import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final String token;
  final String errorMessage;

  const LoginState({
    required this.status,
    this.token = '',
    this.errorMessage = '',
  });

  factory LoginState.initial() => const LoginState(status: LoginStatus.initial);

  LoginState copyWith({
    LoginStatus? status,
    String? token,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, token, errorMessage];
}