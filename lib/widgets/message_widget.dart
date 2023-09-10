import 'package:chatgpt_flutter_case/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.msg, required this.chatIndex}) : super(key: key);

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: chatIndex == 0 ? null : const Color(0xFF191919),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: chatIndex == 0 ? const Color(0xFFC8B6FF) : const Color(0xFFB6FBFF),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatIndex == 0 ? Constants.you : Constants.chatGpt,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13.50,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.38,
                          ),
                        ),
                        chatIndex == 0
                            ? Text(
                                msg,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.50,
                                  fontWeight: FontWeight.w400,
                                  height: 1.52,
                                  letterSpacing: 0.64,
                                ),
                              )
                            : DefaultTextStyle(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.50,
                                  fontWeight: FontWeight.w400,
                                  height: 1.52,
                                  letterSpacing: 0.64,
                                ),
                                child: Text(msg),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
