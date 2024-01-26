import 'package:flutter/material.dart';
import 'package:moodee/forum_item.dart';
import 'package:moodee/models/forum.dart';

class ForumLists extends StatelessWidget {
  const ForumLists(
      {super.key, required this.formPosts, required this.onRemovePost});

  final List<ForumPost> formPosts;
  final void Function(ForumPost forumPost) onRemovePost;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: formPosts.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          formPosts[index],
        ),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        onDismissed: (direction) {
          onRemovePost(formPosts[index]);
        },
        child: ForumItem(
          forumPost: formPosts[index],
        ),
      ),
    ); //if dk length of list items to be shown instead of using column use this
  }
}
