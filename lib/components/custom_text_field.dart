import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color focusedColor;
  final Color unfocusedColor;
  final IconData prefixIconPath;
  final Function(bool)? onFocusChange;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintStyle,
    this.textStyle,
    required this.focusedColor,
    required this.unfocusedColor,
    required this.prefixIconPath,
    this.onFocusChange,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: Focus(
        onFocusChange: (value) {
          setState(() {
            _isFocused = value;
          });
          if (widget.onFocusChange != null) {
            widget.onFocusChange!(value);
          }
        },
        child: TextField(
          keyboardType: TextInputType.text,
          controller: widget.controller,
          style: widget.textStyle,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade50,
            prefixIcon: Icon(
              widget.prefixIconPath,
              color: _isFocused ? widget.focusedColor : widget.unfocusedColor,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: widget.focusedColor),
            ),
            hintText: widget.hintText,
            hintTextDirection: TextDirection.rtl,
            hintStyle: widget.hintStyle,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}