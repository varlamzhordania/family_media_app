import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color btnColor;
  final String buttonText;
  final IconData iconPath;
  final TextStyle textStyle;
  final Function() onPressed;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.width,
    required this.height,
    required this.btnColor,
    required this.buttonText,
    required this.iconPath,
    required this.textStyle,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed, // Disable button when loading
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Button border radius
          ),
        ),
        child: isLoading
            ? Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.white,
            size: 30,
          )
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconPath, color: Colors.white,),
            SizedBox(width: width * 0.02),
            Text(buttonText, style: textStyle),
          ],
        ),
      ),
    );
  }
}