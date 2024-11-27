import 'package:bookshop/colors/Colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final Color? focusColor;
  final Color? disabledColor;
  final Color? splashColor;
  final double? elevation;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final bool loading;
  final bool disabled;
  final double? height;
  final double? width;
  final bool fullWidth;
  final Color? loadingBackgroundColor;

  const CustomButton({
    Key? key,
    this.text,
    this.textStyle,
    this.color,
    this.focusColor,
    this.disabledColor,
    this.splashColor,
    this.elevation,
    this.borderRadius,
    this.onPressed,
    this.loading = false,
    this.disabled = false,
    this.height,
    this.width,
    this.fullWidth = false,
    this.loadingBackgroundColor,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
    return SizedBox(
      height: widget.height ?? 50,
      width:
          widget.fullWidth ? double.infinity : widget.width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.disabled
              ? widget.disabledColor ?? Colors.grey[300]
              : widget.loading
                  ? widget.color ?? CustomColors.pinkMain
                  : widget.color ?? CustomColors.pinkMain,
          foregroundColor: widget.focusColor ?? Colors.white,
          elevation: widget.elevation ?? 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          splashFactory: InkSplash.splashFactory,
          side: widget.disabled || widget.loading
              ? BorderSide.none
              : BorderSide(color: Colors.transparent),
        ),
        onPressed: widget.disabled || widget.loading ? null : widget.onPressed,
        child: widget.loading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: widget.focusColor,
                ),
              )
            : Text(
                widget.text!,
                style: widget.textStyle ??
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
