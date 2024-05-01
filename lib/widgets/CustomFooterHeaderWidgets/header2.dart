import 'package:flutter/material.dart';
import 'package:project_v/constants/app_constants.dart';

class Header2 extends StatelessWidget implements PreferredSizeWidget {
  const Header2({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.4),
      elevation: 4,
      toolbarHeight: 90,
      centerTitle: true,
      title: Image.asset(
        AppConstants.logoImagePath,
        width: 40,
        height: 40,
      ),
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(90);
}
