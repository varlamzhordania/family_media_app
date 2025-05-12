
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RandomFloatingBubble extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool shrink;
  final bool clustering;

  const RandomFloatingBubble({super.key, 
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.shrink,
    required this.clustering,
  });

  @override
  _RandomFloatingBubbleState createState() => _RandomFloatingBubbleState();
}


class _RandomFloatingBubbleState extends State<RandomFloatingBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3 + _random.nextInt(3)),
      vsync: this,
    )..repeat(reverse: true);

    _xAnimation = Tween<double>(
      begin: -10 + _random.nextDouble() * 20,
      end: 10 + _random.nextDouble() * 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _yAnimation = Tween<double>(
      begin: -10 + _random.nextDouble() * 20,
      end: 10 + _random.nextDouble() * 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            widget.clustering ? _xAnimation.value / 2 : _xAnimation.value,
            widget.clustering ? _yAnimation.value / 2 : _yAnimation.value,
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: widget.isSelected
                  ? 160
                  : widget.shrink
                  ? 20
                  : 30,
              height: widget.isSelected
                  ? 160
                  : widget.shrink
                  ? 20
                  : 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SizedBox(
                    width:widget.isSelected
                        ? 160
                        : widget.shrink
                        ? 20
                        : 30,
                    height: widget.isSelected
                        ? 160
                        : widget.shrink
                        ? 20
                        : 30,
                    child: widget.text == "+" ?  Center(
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: widget.isSelected ? 12 : 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ): CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(3), // Border radius
                        child: ClipOval(child: CachedNetworkImage(
                          imageUrl: "https://upload.wikimedia.org/wikipedia/commons/5/55/Justin_Bieber_in_Rosemont%2C_Illinois_%282015%29_%28cropped%29.jpg",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          width: widget.isSelected
                              ? 160 : 30, height: widget.isSelected
                            ? 160 : 30, fit: BoxFit.fill,)
                        ),
                      ),
                    ),
                  ),

                  widget.isSelected ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: widget.isSelected ? 12 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ):
                  const SizedBox()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}