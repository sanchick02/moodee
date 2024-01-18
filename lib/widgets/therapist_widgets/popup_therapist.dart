// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:moodee/presets/colors.dart';
// import 'package:moodee/presets/fonts.dart';
// import 'package:moodee/presets/shadow.dart';
// import 'package:moodee/presets/styles.dart';
// import 'package:moodee/widgets/button.dart';


// class PopUpTherapist extends StatelessWidget {
//   const PopUpTherapist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: AppStyles.borderRadiusAll,
//       ),
//       elevation: 0.0,
//       // backgroundColor: Colors.black,
//       child: contentBox(context),
//     );
//   }

//   Widget contentBox(BuildContext context) {
//     return Container(
//         width: 330,
//         height: 600,
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           color: Colors.white,
//           borderRadius: AppStyles.borderRadiusAll,
//           boxShadow: [AppShadow.innerShadow1, AppShadow.innerShadow2],
//         ),
//         child: Column(
//           // mainAxisSize: MainAxisSize.min,
//           children: [
//             Stack(children: [
//               ClipRRect(
//                 borderRadius: AppStyles.borderRadiusAll,
//                 child: Stack(
//                   children: [
//                     Image.asset(
//                       "lib/assets/images/meshGrad1.png",
//                       width: double.infinity,
//                       height: 120,
//                       fit: BoxFit.cover,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           AppShadow.innerShadow3,
//                           AppShadow.innerShadow4,
//                         ],
//                         color: Colors.transparent,
//                       ),
//                       // image: DecorationImage(
//                       //   image: AssetImage("lib/assets/images/meshGrad1.png"),
//                       //   fit: BoxFit.cover,
//                       // )
//                       child: Stack(
//                         children: [
//                           Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                       padding: const EdgeInsets.only(top: 5),
//                                       constraints:
//                                           const BoxConstraints(maxHeight: 35),
//                                       child: IconButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           icon: Image.asset(
//                                             "lib/assets/icons/close.png",
//                                             width: 35,
//                                           ))),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Therapist",
//                                     style: AppFonts.heading3,
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Feeling down? Start a Conversation.",
//                                     style: AppFonts.smallLightText,
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//             SizedBox(
//               width: double.infinity,
//               height: 480,
//               child: Column(
//                 children: [
//                   const Spacer(),
//                   SizedBox(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             "lib/assets/images/therapist1profile.png",
//                             width: 120,
//                             height: 120,
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 "Sheryl",
//                                 style: AppFonts.largeMediumText,
//                               ),
//                               Text(
//                                 "Psychologist",
//                                 style: AppFonts.smallLightText,
//                               ),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "lib/assets/icons/Rating.png",
//                                     width: 12,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     "4.9",
//                                     style: AppFonts.smallLightText,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   DefaultButton(
//                                     text: "Call",
//                                     press: () {},
//                                     backgroundColor: AppColor.btnColorPrimary,
//                                     height: 25,
//                                     fontStyle:
//                                         AppFonts.extraSmallLightTextWhite,
//                                     width: 75,
//                                     padding: EdgeInsets.zero,
//                                   ),
//                                   const SizedBox(width: 15),
//                                   DefaultButton(
//                                     text: "Message",
//                                     press: () {},
//                                     backgroundColor: AppColor.btnColorPrimary,
//                                     height: 25,
//                                     fontStyle:
//                                         AppFonts.extraSmallLightTextWhite,
//                                     width: 75,
//                                     padding: EdgeInsets.zero,
//                                   )
//                                 ],
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 15),
//                       width: double.infinity,
//                       constraints: const BoxConstraints(minHeight: 50.0),
//                       decoration: BoxDecoration(
//                         borderRadius: AppStyles.borderRadiusAll,
//                         color: AppColor.fontColorPrimary.withOpacity(0.05),
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "Achievements",
//                             style: AppFonts.smallLightText,
//                           ),
//                           Text(
//                             "• Published research contributing to mental health knowledge.",
//                             style: AppFonts.extraSmallLightText,
//                           ),
//                           Text(
//                             "• ABCT Awards in cognitive-behavioral therapy research and practice.",
//                             style: AppFonts.extraSmallLightText,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 15),
//                       width: double.infinity,
//                       constraints: const BoxConstraints(minHeight: 60.0),
//                       decoration: BoxDecoration(
//                         borderRadius: AppStyles.borderRadiusAll,
//                         color: AppColor.fontColorPrimary.withOpacity(0.05),
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "Availability for Consultation",
//                             style: AppFonts.smallLightText,
//                           ),
//                           const SizedBox(height: 5),
//                           // const Column(
//                           //   children: [
//                           //     AvailabilityRows(
//                           //       availabilityList: [],
//                           //     ),
//                           //   ],
//                           // )
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   DefaultButton(
//                     press: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                     text: "Book Consultation",
//                     backgroundColor: AppColor.btnColorPrimary,
//                     height: 40,
//                     fontStyle: AppFonts.normalRegularTextWhite,
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
