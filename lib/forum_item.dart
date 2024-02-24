import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/models/forum.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';
import 'package:moodee/presets/shadow.dart';
import 'package:moodee/presets/styles.dart';

class ForumItem extends StatefulWidget {
  final ForumPost forumPost;

  const ForumItem({Key? key, required this.forumPost}) : super(key: key);

  @override
  State<ForumItem> createState() => _ForumItemState();
}

class _ForumItemState extends State<ForumItem> {
  bool isLiked = false;
  int likesCount = 0;

  String calculateTimeDifference(String postTimeString) {
    DateTime postTime =
        DateTime.parse(postTimeString); // Convert string to DateTime
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min(s) ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr(s) ago';
    } else {
      return '${difference.inDays} day(s) ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Construct the URL for the image from the image path
    String imageUrl = ''; // You should replace this with the actual URL

    // If the image path is not null or empty, construct the URL
    // ignore: unnecessary_null_comparison
    if (widget.forumPost.postImage != null &&
        widget.forumPost.postImage.isNotEmpty) {
      // Assuming your storage bucket URL is 'https://your_storage_bucket_url.com'
      imageUrl = widget.forumPost.postImage;
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          constraints: const BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
            color: AppColor.btnColorSecondary,
            borderRadius: AppStyles.borderRadiusAll,
            boxShadow: [
              AppShadow.innerShadow3,
              AppShadow.innerShadow4,
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: ClipOval(
                        child: widget.forumPost.userImage != ''
                            ? Image.network(
                                widget.forumPost.userImage.toString(),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "lib/assets/images/userAnon.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.forumPost.userName,
                            style: AppFonts.smallLightText,
                          ), // CHANGE TO USER NAME FROM FIREBASE
                          Text(
                            calculateTimeDifference(widget.forumPost.time),
                            style: AppFonts
                                .extraSmallLightText, // Adjusted font size
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.forumPost.caption,
                        style: AppFonts.smallLightText,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Increased spacing
                // Display the image if there is one
                if (imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      imageUrl,
                      width:
                          double.infinity, // Make the image take the full width
                      height: 200, // Adjust the height as needed
                      fit: BoxFit.cover, // Cover the space with the image
                    ),
                  ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 35,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked; // Toggle the liked state
                            likesCount += isLiked ? 1 : -1;
                          });
                        },
                        icon: Image.asset(
                          isLiked
                              ? "lib/assets/icons/liked.png"
                              : "lib/assets/icons/unliked.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      // '${widget.forumPost.likes}',
                      '$likesCount',
                      style: AppFonts.smallLightText, // Adjusted font size
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
