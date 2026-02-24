import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
            if (state.status == LoginStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login success. Token: ${state.token}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.status == LoginStatus.loading;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passCtrl,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (v) => setState(() => rememberMe = v ?? false),
                    ),
                    const Text('Remember me'),
                  ],
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  title: 'Login',
                  isLoading: isLoading,
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginSubmitted(
                      email: emailCtrl.text.trim(),
                      password: passCtrl.text.trim(),
                      rememberMe: rememberMe,
                    ));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}