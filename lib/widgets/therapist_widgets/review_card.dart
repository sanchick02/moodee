import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:moodee/presets/colors.dart';
import 'package:moodee/presets/fonts.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    Key? key,
    required this.name,
    required this.image,
    required this.time,
    required this.caption,
    required this.rating,
  }) : super(key: key);

  final String name;
  final String image;
  final String time;
  final String caption;
  final double rating;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: AppColor.fontColorPrimary.withOpacity(0.05),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: ClipOval(
                        child: Image.asset(
                          widget.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: AppFonts.smallLightText,
                        ),
                        Text(
                          widget.time,
                          style: AppFonts.extraSmallLightText,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "lib/assets/icons/Rating.png",
                      width: 12,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.rating.toString(),
                      style: AppFonts.extraSmallLightText,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.caption, // Using widget.caption here
                  style: AppFonts.extraSmallLightText,
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8), // Increased spacing
        ],
      ),
    );
  }
}
