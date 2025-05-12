import 'package:flutter/material.dart';

import '../../utils/theme_colors.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Text("Message"),
      ),
    ));
  }
}
