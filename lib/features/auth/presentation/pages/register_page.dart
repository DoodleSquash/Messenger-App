import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/theme.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_event.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_state.dart';
import 'package:messenger/features/auth/presentation/widgets/auth_button.dart';
import 'package:messenger/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:messenger/features/auth/presentation/widgets/login_prompt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onRegister() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthInputField(
                  hint: 'Username',
                  icon: Icons.person,
                  controller: _usernameController),
              SizedBox(height: 20),
              AuthInputField(
                  hint: 'Email',
                  icon: Icons.email,
                  controller: _emailController),
              SizedBox(height: 20),
              AuthInputField(
                  hint: 'Password',
                  icon: Icons.password,
                  controller: _passwordController),
              SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return AuthButton(text: 'Register', onPressed: _onRegister);
                },
                listener: (context, state) {
                  print("Current state: $state");
                  if (state is AuthSuccess) {
                    Navigator.pushNamed(context, '/login');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              LoginPrompt(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                title: "Already have an account? ",
                subtitle: "click here to Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
