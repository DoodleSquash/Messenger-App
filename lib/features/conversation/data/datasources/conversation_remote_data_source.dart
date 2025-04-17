import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:messenger/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConversationRemoteDataSource {
  final String baseUrl = 'http://192.168.0.109:6000/auth';
  final _storage = FlutterSecureStorage();

  Future<List<ConversationModel>> fetchConverstaions() async {
    String token = await _storage.read(key: 'token') ?? '';
    final response =
        await http.get(Uri.parse('$baseUrl/conversations'), 
        headers: {
              'Authorization':'Bearer $token',
        });

        print(response.body);

    if (response.statusCode == 200) {
       List data =jsonDecode( response.body); // Assuming the response is a list of conversations
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }
}
