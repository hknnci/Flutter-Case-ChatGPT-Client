import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/chat_model.dart';

class ChatStorage {
  static const _key = 'chatList';

  static Future<List<ChatModel>> loadChatList() async {
    final prefs = await SharedPreferences.getInstance();
    final chatListJson = prefs.getString(_key);
    if (chatListJson != null) {
      final List<dynamic> decodedList = json.decode(chatListJson);
      return decodedList.map((item) => ChatModel.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> saveChatList(List<ChatModel> chatList) async {
    final prefs = await SharedPreferences.getInstance();
    final chatListJson = json.encode(chatList);
    await prefs.setString(_key, chatListJson);
  }
}
