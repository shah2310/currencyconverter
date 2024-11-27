import 'package:bookshop/colors/Colors.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? elevation;
  final double? preferredHeight;

  const CustomHeader({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.titleColor,
    this.elevation,
    this.preferredHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? CustomColors.pinkMain,
      elevation: elevation ?? 2,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyle(color: titleColor ?? Colors.white),
      ),
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? kToolbarHeight);
}
