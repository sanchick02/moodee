import 'package:flutter/material.dart';
import 'package:moodee/forum_item.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:provider/provider.dart';

class ForumLists extends StatelessWidget {
  const ForumLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ForumProvider>(context, listen: false);

    return ListView.builder(
      itemCount: _provider.forumPosts.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_provider.forumPosts[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        onDismissed: (direction) {
          // onRemovePost(_provider.forumPosts[index], context);
        },
        child: ForumItem(forumPost: _provider.forumPosts[index]),
      ),
    );
  }
}
