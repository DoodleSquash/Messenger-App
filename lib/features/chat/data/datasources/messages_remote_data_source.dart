import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/features/chat/data/models/message_model.dart';
import 'package:messenger/features/chat/domain/entities/message_entity.dart';

class MessagesRemoteDataSource {
  final String baseUrl = 'http://localhost:6000';
  final _storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'token') ?? '';
    if (token.isEmpty) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/messages/$conversationId'),
      headers: {'Authorization':' Bearer $token',}
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body); 
      return data.map((json) => MessageModel.fromJson(json)).toList();
      }else{
        
        throw Exception( 'Failed to load messages');
      }
}
}
