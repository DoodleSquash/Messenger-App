import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/core/theme.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_event.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_state.dart';
import 'package:messenger/features/auth/presentation/widgets/auth_button.dart';
import 'package:messenger/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:messenger/features/auth/presentation/widgets/login_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _showInputValues() {
    String password = _passwordController.text;
    String email = _emailController.text;

    print("Email: $email - Password: $password");
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
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
                    return AuthButton(text: "Login", onPressed: _onLogin);
                  },
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamed(context, '/chatPage');
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                LoginPrompt(
                    onTap: () {},
                    title: "Dont have an account? ",
                    subtitle: "Click here to  register")
              ]),
        ),
      ),
    );
  }

  // Widget _buildTextInput(
  //     String hint, IconData icon, TextEditingController controller,
  //     {bool isPassword = false}) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: DefaultColors.sentMessageInput,
  //       borderRadius: BorderRadius.circular(25),
  //     ),
  //     padding: EdgeInsets.symmetric(horizontal: 20),
  //     child: Row(
  //       children: [
  //         Icon(
  //           icon,
  //           color: Colors.grey,
  //         ),
  //         SizedBox(width: 10),
  //         Expanded(
  //           child: TextField(
  //             controller: controller,
  //             obscureText: isPassword,
  //             decoration: InputDecoration(
  //               hintText: hint,
  //               hintStyle: TextStyle(color: Colors.grey),
  //               border: InputBorder.none,
  //             ),
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildRegisterButton() {
  //   return ElevatedButton(
  //     onPressed: _showInputValues,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: DefaultColors.buttonColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(25),
  //       ),
  //       padding: EdgeInsets.symmetric(vertical: 20),
  //     ),
  //     child: Text(
  //       'Login',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  // Widget _buildLoginPrompt() {
  //   return Center(
  //     child: GestureDetector(
  //       onTap: () {},
  //       child: RichText(
  //           text: TextSpan(
  //         text: 'Dont have an account?',
  //         style: TextStyle(color: Colors.grey),
  //         children: [
  //           TextSpan(
  //             text: ' Click here to Register',
  //             style: TextStyle(
  //               color: Colors.blue,
  //             ),
  //           ),
  //         ],
  //       )),
  //     ),
  //   );
  // }
}
