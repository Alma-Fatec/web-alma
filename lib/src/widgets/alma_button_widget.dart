import 'package:flutter/material.dart';

class AlmaButtonWidget extends StatelessWidget {
  const AlmaButtonWidget(
      {super.key,
      required this.onPressed,
      this.color,
      this.height,
      this.width,
      this.iconData,
      required this.child});

  final Function onPressed;
  final Color? color;
  final double? height;
  final double? width;
  final IconData? iconData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
              Size(width ?? 200, height ?? 48)),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [iconData == null ? Container() : Icon(iconData), child],
        ),
      ),
    );
  }
}
