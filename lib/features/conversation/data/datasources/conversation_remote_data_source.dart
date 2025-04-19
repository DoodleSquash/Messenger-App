import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messenger/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConversationRemoteDataSource {
  final String baseUrl = 'http://192.168.0.109:6000';
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConverstaions() async {
    final String token = await _storage.read(key: 'token') ?? '';
    if (token.isEmpty) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      List data = jsonDecode(
          response.body); // Assuming the response is a list of conversations
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error ?? 'Failed to load conversations');
    }
  }
}
