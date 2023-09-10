import 'package:chatgpt_flutter_case/utils/constants.dart';

class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  Map<String, dynamic> toJson() {
    return {
      Constants.msg: msg,
      Constants.chatIndex: chatIndex,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json[Constants.msg],
        chatIndex: json[Constants.chatIndex],
      );
}
