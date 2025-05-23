import 'dart:convert';
import 'package:messenger/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = 'http://192.168.0.109:6000/auth';

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    return UserModel.fromJson(jsonDecode(response.body)['user']);
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print("Response body: ${response.body}");

if (response.statusCode == 200 || response.statusCode == 201) {

      final responseData = jsonDecode(response.body);
      if (responseData['user'] == null) {
        throw Exception("User data is missing in the response");
      }
      return UserModel.fromJson(responseData['user']);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error ?? "Failed to register user");
    }
  }
}
