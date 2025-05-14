
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/theme_colors.dart';

SizedBox decField(double height, BuildContext context, TextEditingController decEditingController, FocusNode focusNodeDec  ) {
  return SizedBox(
    height: height * 0.12,
    child: TextField(
      maxLines: 50,
      keyboardType: TextInputType.text,
      focusNode: focusNodeDec,
      controller: decEditingController,
      style: GoogleFonts.rubik().copyWith(
          fontSize: 12, fontWeight: FontWeight.w400, color: textColorBody),
      decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: hintColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: borderColor),
          ),
          hintText: AppLocalizations.of(context)!.telUsPost,
          hintStyle: GoogleFonts.rubik().copyWith(
              fontSize: 12, fontWeight: FontWeight.w400, color: hintColor),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: InputBorder.none),
    ),
  );
}
