import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class SettingRow extends StatefulWidget {
  final String pass;
  final String nameAccount;
  final String paymentDate;
  final String banck;
  final VoidCallback onPressed;
  const SettingRow({super.key, required this.onPressed, required this.pass, required this.nameAccount, required this.paymentDate, required this.banck });

  @override
  State<SettingRow> createState() => _SettingRowState();
}

class _SettingRowState extends State<SettingRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 22,
            ),
            Expanded(
              child: Text(
                widget.nameAccount,
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