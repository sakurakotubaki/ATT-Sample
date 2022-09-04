import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

String _authStatus = 'Unknown';

Future<void> initPlugin(context) async {
  final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  _authStatus = '$status';
  // If the system can show an authorization request dialog
  if (status == TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    await showCustomTrackingDialog(context);
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Request system's tracking authorization dialog
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    _authStatus = '$status';
  }

  final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
  print("UUID: $uuid");
}

Future<void> showCustomTrackingDialog(BuildContext context) async =>
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ユーザーの皆様へ'),
        content: const Text(
            '私たちはあなたのプライバシーとデータのセキュリティを気にしています。私たちは広告を表示することで、このアプリを無料に保っています。'
            '私たちのパートナーはデータを収集し、あなたのデバイスにあるユニークな識別子を使用して広告を表示します'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('継続'),
          ),
        ],
      ),
    );
