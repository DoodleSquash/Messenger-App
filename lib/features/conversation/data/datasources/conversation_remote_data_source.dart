import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/features/conversation/data/models/conversation_model.dart';

class ConversationRemoteDataSource {
  final String baseUrl = 'http://192.168.0.109:6000/auth';
  final _storage = FlutterSecureStorage();
}

Future<List<ConversationModel>> fetchco
