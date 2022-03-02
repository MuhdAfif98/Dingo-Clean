import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool previous;
  final bool primaryBg;
  final Color? color;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onBackPressed;
  const ThemeAppBar(
    this.title, {
    Key? key,
    this.previous = true,
    this.primaryBg = true,
    this.color = Colors.transparent,
    this.trailing,
    this.leading,
    this.onBackPressed,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: previous
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 24,
              icon: Icon(
                Iconsax.arrow_left,
                color: primaryBg ? Colors.white : Colors.black,
              ),
            )
          : const SizedBox(),
      actions: <Widget>[
        trailing ?? const SizedBox(),
      ],
      title: Text(
        title ?? "",
        style: TextStyle(
          color: primaryBg ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color,
      // border: Border.symmetric(vertical: BorderSide.none),
      // middle: Text(
      //   "",
      //   style: TextStyle(
      //     fontFamily: 'Poppins',
      //     fontWeight: FontWeight.normal,
      //   ),
      // ),
    );
  }
}
