// import 'package:flutter/material.dart';
// import 'package:moodee/presets/colors.dart';
// import 'package:moodee/presets/fonts.dart';
// import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

// class AudioRoom extends StatelessWidget {
//   final String roomID;
//   final bool isHost;

//   const AudioRoom({Key? key, required this.roomID, this.isHost = false})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Stack(
//         children: [
//           ZegoUIKitPrebuiltLiveAudioRoom(
//             appID:
//                 1690259054, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
//             appSign:
//                 "b9ad1f1db84175c098827915a48866145c30e8010e0dd5c9010eac8482d52290", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
//             userID: 'user_id',
//             userName: 'user_name',
//             roomID: roomID,
//             config: isHost
//                 ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
//                 : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
//               ..seatConfig.showSoundWaveInAudioMode = false
//               // ..userAvatarUrl = 'your_avatar_url'
//               ..background = background()
//               ..layoutConfig.rowConfigs = [
//                 ZegoLiveAudioRoomLayoutRowConfig(
//                     count: 3,
//                     alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
//                 ZegoLiveAudioRoomLayoutRowConfig(
//                     count: 3,
//                     alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround)
//               ]
//               ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
//                 maxCount: 5,
//                 hostButtons: [
//                   ZegoMenuBarButtonName.toggleMicrophoneButton,
//                   ZegoMenuBarButtonName.showMemberListButton,
//                 ],
//                 speakerButtons: [
//                   ZegoMenuBarButtonName.toggleMicrophoneButton,
//                   ZegoMenuBarButtonName.showMemberListButton,
//                 ],
//               ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget background() {
//     return Stack(
//       children: [
//         Image.asset(
//           "lib/assets/images/meshGrad1.png",
//           fit: BoxFit.cover,
//           height: double.infinity,
//           width: double.infinity,
//         ),
//         Column(
//           children: [
//             AppBar(
//               backgroundColor: Colors.transparent,
//               title: Image.asset(
//                 "lib/assets/images/Logo.png",
//                 width: 120,
//               ),
//               centerTitle: true,
//               leading: IconButton(
//                 onPressed: () {
//                   // Navigator.pop(context);
//                 },
//                 icon: Image.asset(
//                   "lib/assets/icons/arrow_back_gray_small.png",
//                   width: 30,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 10 + 20,
//               left: 10,
//               child: Text(
//                 "Live Audio Room ID: $roomID",
//                 overflow: TextOverflow.ellipsis,
//                 style: AppFonts.smallLightText,
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:moodee/presets/fonts.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class AudioRoom extends StatefulWidget {
  final String roomID;
  final bool isHost;

  const AudioRoom({
    Key? key,
    required this.roomID,
    this.isHost = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AudioRoomState();
}

class AudioRoomState extends State<AudioRoom> {
  final liveController = ZegoLiveAudioRoomController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ZegoUIKitPrebuiltLiveAudioRoom(
            appID:
                1690259054, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
            appSign:
                "b9ad1f1db84175c098827915a48866145c30e8010e0dd5c9010eac8482d52290", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
            userID: 'user_id',
            userName: 'user_name',
            roomID: widget.roomID,
            controller: liveController,
            config: (widget.isHost
                ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
                : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience())

              // ..takeSeatIndexWhenJoining =
              //     widget.isHost ? getHostSeatIndex() : -1
              // ..hostSeatIndexes = getLockSeatIndex()
              ..layoutConfig.rowConfigs = [
                ZegoLiveAudioRoomLayoutRowConfig(
                    count: 3,
                    alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
                ZegoLiveAudioRoomLayoutRowConfig(
                    count: 3,
                    alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
                ZegoLiveAudioRoomLayoutRowConfig(
                    count: 3,
                    alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
                ZegoLiveAudioRoomLayoutRowConfig(
                    count: 3,
                    alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
              ]
              // ..seatConfig = getSeatConfig()
              ..background = background()

              // ..userAvatarUrl = 'https://robohash.org/$localUserID.png'
              ..onUserCountOrPropertyChanged = (List<ZegoUIKitUser> users) {
                debugPrint(
                    'onUserCountOrPropertyChanged:${users.map((e) => e.toString())}');
              }
              ..onSeatClosed = () {
                debugPrint('on seat closed');
              }
              ..onSeatsOpened = () {
                debugPrint('on seat opened');
              }
              ..onSeatsChanged = (
                Map<int, ZegoUIKitUser> takenSeats,
                List<int> untakenSeats,
              ) {
                debugPrint(
                    'on seats changed, taken seats:$takenSeats, untaken seats:$untakenSeats');
              }
              ..onSeatTakingRequested = (ZegoUIKitUser audience) {
                debugPrint('on seat taking requested, audience:$audience');
              }
              ..onSeatTakingRequestCanceled = (ZegoUIKitUser audience) {
                debugPrint(
                    'on seat taking request canceled, audience:$audience');
              }
              ..onInviteAudienceToTakeSeatFailed = () {
                debugPrint('on invite audience to take seat failed');
              }
              ..onSeatTakingInviteRejected = () {
                debugPrint('on seat taking invite rejected');
              }
              ..onSeatTakingRequestFailed = () {
                debugPrint('on seat taking request failed');
              }
              ..onSeatTakingRequestRejected = () {
                debugPrint('on seat taking request rejected');
              }
              ..onHostSeatTakingInviteSent = () {
                debugPrint('on host seat taking invite sent');
              }

              /// WARNING: will override prebuilt logic
              // ..onSeatClicked = (int index, ZegoUIKitUser? user) {
              //   debugPrint(
              //       'on seat clicked, index:$index, user:${user.toString()}');
              // }

              /// WARNING: will override prebuilt logic
              ..onMemberListMoreButtonPressed = onMemberListMoreButtonPressed,
          );
        },
      ),
    );
  }

  // Widget foreground(BoxConstraints constraints) {
  //   return Container();

  //   return simpleMediaPlayer(
  //     canControl: widget.isHost,
  //     liveController: liveController,
  //   );

  //   return advanceMediaPlayer(
  //     constraints: constraints,
  //     canControl: widget.isHost,
  //   );
  // }

  Widget background() {
    return Stack(
      children: [
        Image.asset(
          "lib/assets/images/meshGrad1.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Column(
          children: [
            AppBar(
              leading: null,
              backgroundColor: Colors.transparent,
              title: Image.asset(
                "lib/assets/images/Logo.png",
                width: 120,
              ),
              centerTitle: true,
            ),
            Positioned(
              top: 10 + 20,
              left: 10,
              child: Text(
                "Live Audio Room ID: ${widget.roomID}",
                overflow: TextOverflow.ellipsis,
                style: AppFonts.smallLightText,
              ),
            )
          ],
        ),
      ],
    );
  }

  // ZegoLiveAudioRoomSeatConfig getSeatConfig() {
  //   if (widget.layoutMode == LayoutMode.hostTopCenter) {
  //     return ZegoLiveAudioRoomSeatConfig(
  //       backgroundBuilder: (
  //         BuildContext context,
  //         Size size,
  //         ZegoUIKitUser? user,
  //         Map<String, dynamic> extraInfo,
  //       ) {
  //         return Container(color: Colors.grey);
  //       },
  //     );
  //   }

  //   return ZegoLiveAudioRoomSeatConfig(
  //       // avatarBuilder: avatarBuilder,
  //       );
  // }

  Widget avatarBuilder(
    BuildContext context,
    Size size,
    ZegoUIKitUser? user,
    Map<String, dynamic> extraInfo,
  ) {
    return CircleAvatar(
      maxRadius: size.width,
      backgroundImage: Image.asset(
              "assets/avatars/avatar_${((int.tryParse(user?.id ?? "") ?? 0) % 6).toString()}.png")
          .image,
    );
  }

  // int getHostSeatIndex() {
  //   if (widget.layoutMode == LayoutMode.hostCenter) {
  //     return 4;
  //   }

  //   return 0;
  // }

  // List<int> getLockSeatIndex() {
  //   if (widget.layoutMode == LayoutMode.hostCenter) {
  //     return [4];
  //   }

  //   return [0];
  // }

  void onMemberListMoreButtonPressed(ZegoUIKitUser user) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff111014),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        const textStyle = TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
        final listMenu = liveController.localHasHostPermissions
            ? [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();

                    ZegoUIKit().removeUserFromRoom(
                      [user.id],
                    ).then((result) {
                      debugPrint('kick out result:$result');
                    });
                  },
                  child: Text(
                    'Kick Out ${user.name}',
                    style: textStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();

                    liveController
                        ?.inviteAudienceToTakeSeat(user.id)
                        .then((result) {
                      debugPrint('invite audience to take seat result:$result');
                    });
                  },
                  child: Text(
                    'Invite ${user.name} to take seat',
                    style: textStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: textStyle,
                  ),
                ),
              ]
            : [];
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 60,
                  child: Center(child: listMenu[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
