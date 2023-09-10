import "dart:convert";
import "dart:developer";
import "dart:io";

import "package:chatgpt_flutter_case/utils/constants.dart";
import "package:chatgpt_flutter_case/utils/models/chat_model.dart";
import "package:http/http.dart" as http;

class Api {
  static Future<List<ChatModel>> sendMessage({required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.baseURL}/chat/completions"),
        headers: {"Authorization": "Bearer ${Constants.apiKey}", "Content-Type": "application/json"},
        body: jsonEncode({
          "model": Constants.modelName,
          "messages": [
            {"role": "user", "content": message}
          ],
          "temperature": 0.7
        }),
      );

      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(msg: jsonResponse["choices"][index]["message"]["content"], chatIndex: 1),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
