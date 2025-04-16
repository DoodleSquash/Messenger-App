import 'package:messenger/features/auth/domain/entities/user_entity.dart';
import 'package:messenger/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase({required this.repository});

  Future<UserEntity> call(String username, String email, String password) async {
    return repository.register(username,email, password);
  }
}
  