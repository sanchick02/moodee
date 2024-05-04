import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodee/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart' as zego;
import '../../common.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<StatefulWidget> createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
  zego.ZegoUIKitPrebuiltCallController? callController;

  @override
  void initState() {
    super.initState();
    callController = zego.ZegoUIKitPrebuiltCallController();
  }

  @override
  void dispose() {
    super.dispose();
    // callController = null;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    String userName = (provider.userProviderData!.firstName).toString();
    String localUserID = FirebaseAuth.instance.currentUser!.uid;

    return SafeArea(
      child: zego.ZegoUIKitPrebuiltCall(
        appID: 914702262 /*input your AppID*/,
        appSign:
            'd9c7a3aac70c1bad710ee42095f7f2df55264243b8f2d47fc25fe0b22e534cd7' /*input your AppSign*/,
        userID: localUserID,
        userName: userName,
        callID: 'Hello',
        controller: callController,
        config: zego.ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

          /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            zego.ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..avatarBuilder = customAvatarBuilder

          ///
          ..onOnlySelfInRoom = (context) {
            if (zego.PrebuiltCallMiniOverlayPageState.idle !=
                zego.ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}
