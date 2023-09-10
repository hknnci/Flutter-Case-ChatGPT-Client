import 'dart:developer';

import 'package:chatgpt_flutter_case/controller/chat_controller.dart';
import 'package:chatgpt_flutter_case/utils/chat_storage.dart';
import 'package:chatgpt_flutter_case/utils/constants.dart';
import 'package:chatgpt_flutter_case/utils/models/chat_model.dart';
import 'package:chatgpt_flutter_case/utils/services/api.dart';
import 'package:chatgpt_flutter_case/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  final ChatController controller = Get.find();

  final TextEditingController messageTEC = TextEditingController();
  final FocusNode messageFN = FocusNode();
  final ScrollController _listSC = ScrollController();

  List<ChatModel> chatList = [];

  @override
  void initState() {
    super.initState();
    loadChatList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollListToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          Constants.chatBotTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.32,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: Constants.deleteChat,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(Constants.deleteChat),
                    content: Text(Constants.deleteThisChat),
                    actions: [
                      TextButton(
                        child: Text(Constants.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(Constants.delete),
                        onPressed: () {
                          deleteAllMessagesFromSharedPreferences();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _listSC,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  msg: chatList[index].msg,
                  chatIndex: chatList[index].chatIndex,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: messageTEC,
                    focusNode: messageFN,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.50,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.38,
                    ),
                    decoration: InputDecoration(
                      hintText: Constants.message,
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.50,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.38,
                      ),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFb6fbff)),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          color: Colors.black,
                          onPressed: () async {
                            await sendMessageFunction(chatList: chatList, message: messageTEC.text);
                          },
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                    ),
                    onFieldSubmitted: (value) async =>
                        await sendMessageFunction(chatList: chatList, message: messageTEC.text),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void scrollListToEnd() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (_listSC.hasClients) {
          _listSC.animateTo(
            _listSC.position.maxScrollExtent,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  void loadChatList() async {
    final chatList = await ChatStorage.loadChatList();
    setState(() {
      this.chatList = chatList;
    });
  }

  Future<void> deleteAllMessagesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatList');
    setState(() {
      chatList.clear();
    });
  }

  Future<void> sendMessageFunction({required List<ChatModel> chatList, required String message}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("You can't send multiple messages!"),
          backgroundColor: Colors.amber,
        ),
      );
    }
    if (messageTEC.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Please type a message!"),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }
    try {
      String msg = messageTEC.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: msg, chatIndex: 0));
        messageTEC.clear();
        messageFN.unfocus();
      });
      chatList.addAll(await Api.sendMessage(message: msg, modelId: Constants.modelName));
      await ChatStorage.saveChatList(chatList);
      final loadedChatList = await ChatStorage.loadChatList();
      setState(() {
        chatList = loadedChatList;
      });
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
}
