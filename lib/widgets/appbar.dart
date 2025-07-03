import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? ontap;

  const CustomIcon({super.key, required this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: ontap, icon: Icon(icon));
  }
}

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? left;
  final IconData? right;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const MyAppbar({
    super.key,
    this.title,
    this.left,
    this.right,
    this.onLeftPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading:
          left != null ? CustomIcon(icon: left!, ontap: onLeftPressed) : null,
      title: Text(title ?? ''),
      backgroundColor: const Color(0xFFB08D57),
      actions: [
        if (right != null) CustomIcon(icon: right!, ontap: onRightPressed),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
