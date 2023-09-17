import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});
  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Settings"),
      ),
    );
  }
}
