import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/features/auth/domain/usecases/login_use_case.dart';
import 'package:messenger/features/auth/domain/usecases/register_use_case.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_event.dart';
import 'package:messenger/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase})
      : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.call(
        event.username,
        event.email,
        event.password,
      );
      print("User registered: $user");
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      print("Registration error: $e");
      emit(AuthFailure(error: "Registration failed: $e"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.call(
        event.email,
        event.password,
      );
      await _storage.write(key: 'token', value: user.token);
      print('token: ${user.token}');
      emit(AuthSuccess(message: "Login successful"));
    } catch (e) {
      emit(AuthFailure(error: "Login failed"));
    }
  }
}
