import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../generated/assets.dart';
import '../utils/theme_colors.dart';

class header extends StatelessWidget {
  final String title;
  final bool checked_pop;
  const header({
    super.key,
    required double width, required this.title, required this.checked_pop,
  }) : _width = width;

  final double _width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // This will distribute space evenly
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.pop(context, checked_pop)
            },
            child: Center(
              child: SvgPicture.asset(
                width: 22,
                height: 22,
                fit: BoxFit.fill,
                color: Colors.black,
                Assets.iconsArrowChevronLeft,
                semanticsLabel: 'back to Profile',
              ),
            ),
          ),

          Expanded( // This will take all available space and center the text
            child: Text(
              title,
              textAlign: TextAlign.center, // Center the text within the Expanded
              style: GoogleFonts.rubik().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: textColor
              ),
            ),
          ),

        ],
      ),
    );
  }
}
