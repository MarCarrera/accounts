import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class SettingRow extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  const SettingRow({super.key, required this.icon, required this.title, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon,
                height: 22, width: 22, fit: BoxFit.contain),
            const SizedBox(
              width: 22,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 38,
                  width: 26,
                  child: Icon(
                    Icons.remove_red_eye,
                    color: TColor.black,
                    size: 22,
                  ),
                ),
                const SizedBox(
              width: 22,
            ),
                SizedBox(
                  height: 38,
                  width: 26,
                  child: Icon(
                    Icons.copy,
                    color: TColor.black,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}