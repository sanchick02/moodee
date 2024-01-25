import 'package:flutter/material.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'common.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<StatefulWidget> createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
  ZegoUIKitPrebuiltCallController? callController;

  @override
  void initState() {
    super.initState();
    callController = ZegoUIKitPrebuiltCallController();
  }

  @override
  void dispose() {
    super.dispose();

    callController = null;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    String userName = (provider.userProviderData!.firstName).toString();
    String localUserID = (provider.userProviderData!.uid).toString();

    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 569492539 /*input your AppID*/,
        appSign:
            'aaaa0e0391972c5cbb94d292f1db2d3b5dcf4921f79026c9cab3771415a6269b' /*input your AppSign*/,
        userID: localUserID,
        userName: userName,
        callID: 'Hello',
        controller: callController,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

          /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..avatarBuilder = customAvatarBuilder

          ///
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              /// now is minimizing state, not need to navigate, just switch to idle
              ZegoUIKitPrebuiltCallMiniOverlayMachine().switchToIdle();
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}
