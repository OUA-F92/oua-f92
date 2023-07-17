import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String userId;
  final String userName;
  final String conferenceId;
  const VideoConferencePage({super.key, required this.userId, required this.userName, required this.conferenceId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1521978064, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "8c314a6a54c428b1a049f6d16e610b0e879252ba8b3a4299a835ecace78bc519", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: userId,
        userName: userName,
        conferenceID: conferenceId,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
