import 'package:flutter/material.dart';
import 'package:moodee/widgets/community_widgets/forum_item.dart';
import 'package:moodee/providers/forum_post_provider.dart';
import 'package:provider/provider.dart';

class ForumLists extends StatelessWidget {
  const ForumLists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ForumProvider>(context, listen: false);
    return Column(
      children: List.generate(
        _provider.forumPosts.length,
        (index) => Dismissible(
          key: ValueKey(_provider.forumPosts[index]),
          onDismissed: (direction) {
            // onRemovePost(_provider.forumPosts[index], context);
          },
          child: ForumItem(forumPost: _provider.forumPosts[index]),
        ),
      ),
    );
  }
}
