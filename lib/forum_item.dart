import 'package:flutter/material.dart';
import 'package:moodee/models/forum.dart';

class ForumItem extends StatelessWidget {
  const ForumItem({super.key, required this.forumPost});

  final ForumPost forumPost;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            forumPost.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('\$${forumPost.title}'),
              const Spacer(),
              Text(
                forumPost.topic,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                forumPost.subject,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              Text(
                forumPost.likes.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}


              // Text(

          