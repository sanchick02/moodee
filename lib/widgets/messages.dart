import 'package:flutter/material.dart';

import '../utils/size.dart';
import '../utils/style.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final String name;
  final Function onAnimatedTextFinished;
  final isAnimated = ValueNotifier(false);

  Messages({
    Key? key,
    required this.isUser,
    required this.message,
    required this.date,
    required this.name,
    required this.onAnimatedTextFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(small),
      margin: const EdgeInsets.symmetric(vertical: small).copyWith(
        left: isUser ? 100 : xsmall,
        right: isUser ? xsmall : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? userChat : resChat,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(xsmall),
          bottomLeft: isUser ? const Radius.circular(xsmall) : Radius.zero,
          topRight: const Radius.circular(xsmall),
          bottomRight: !isUser ? const Radius.circular(xsmall) : Radius.zero,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Text(
              message,
              style: messageText,
            ),
          if (isUser)
            Text(
              message,
              style: messageText,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: dateText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
