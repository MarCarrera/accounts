import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class SettingRow extends StatefulWidget {
  final String paymentDate;
  final String nameUser;
  final String paymentAmount;
  final VoidCallback onPressed;
  const SettingRow({super.key, required this.onPressed, required this.paymentDate, required this.nameUser, required this.paymentAmount });

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
                widget.paymentDate,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.nameUser,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.paymentAmount,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}