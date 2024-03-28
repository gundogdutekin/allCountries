import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final bool? isIcon;
  final IconData? newIcon;
  final String? appTitle;

  const CustomAppBar(
      {super.key, this.appTitle, this.height, this.isIcon, this.newIcon});
  @override
  Size get preferredSize => Size.fromHeight(height ?? 40);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: isIcon == true
          ? IconButton(
              color: Colors.white,
              icon: Icon(newIcon ?? Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : Container(),
      title: Text(
        appTitle ?? "",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 113, 153, 223),
    );
  }
}
