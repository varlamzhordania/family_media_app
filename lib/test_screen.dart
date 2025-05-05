

import 'dart:math';

import 'package:flutter/material.dart';

import 'components/animation_family.dart';

class BubbleScreen extends StatefulWidget {
  List<String>? bubbles;
  BubbleScreen({required this.bubbles});

  @override
  _BubbleScreenState createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> {
  List<String> selectedBubbles = [];

  @override
  Widget build(BuildContext context) {
    // final bubbles = [
    //   'Tournament',
    //   'Flight Booking',
    //   'Barber Shop',
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Bubble Animation'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: widget.bubbles!.map((bubble) {
              bool isSelected = selectedBubbles.contains(bubble);
              return RandomFloatingBubble(
                text: bubble,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedBubbles.remove(bubble);
                    } else {
                      selectedBubbles.add(bubble);
                    }
                  });
                },
                shrink: selectedBubbles.isNotEmpty && !isSelected,
                clustering: selectedBubbles.length > 1,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}







