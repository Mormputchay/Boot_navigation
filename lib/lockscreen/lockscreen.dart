import 'package:boot_navigation/buildApi.dart';
import 'package:flutter/material.dart';

import 'comm_widget/PinLockScreen.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});
  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade700,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/flutter.png",
              fit: BoxFit.cover,
              width: 230,
              height: 230,
            ),
            PinLockScreen(
              correctPin: 1111,
              pinLength: 4,
              onPinMatched: (pin) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuilderApiScreen()));
              },
              onPinChanged: (pin) {},
              disableDotColor: Colors.black26,
              wrongPinDotColor: Colors.red,
              filledPinDotColor: Colors.white,
              dotsShape: BoxShape.circle,
              buttonBackgroundColor: Colors.black45.withOpacity(0.5),
              buttonForegroundColor: Colors.white,
              buttonBorderRadius: 60,
              buttonSize: const Size(70.0, 70.0),
              numPadVerticalSpacing: 30,
              numPadHorizontalSpacing: 30,
            ),
          ],
        ),
      ),
    );
  }
}
