import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final Color? focusBorderColor;
  final double? focusBorderWidth;
  final Color? focusLabelColor;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.validator,
    this.focusBorderColor,
    this.focusBorderWidth,
    this.focusLabelColor,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: widget.textStyle,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 18,
          color: _focusNode.hasFocus
              ? widget.focusLabelColor ?? Colors.pink
              : widget.labelStyle?.color ?? Colors.grey[600],
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.grey[200],
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: BorderSide(
              color: widget.borderColor ?? Colors.grey[400]!,
              width: widget.borderWidth ?? 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: BorderSide(
            color: widget.focusBorderColor ?? Colors.blue,
            width: widget.focusBorderWidth ?? 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          borderSide: BorderSide(
              color: widget.borderColor ?? Colors.grey[400]!,
              width: widget.borderWidth ?? 1),
        ),
      ),
    );
  }
}
