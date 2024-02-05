import 'package:expandable_fab_menu/expandable_fab_menu.dart';
import 'package:fitness/view/utils/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ButtonOptions extends StatefulWidget {
  const ButtonOptions({super.key});

  @override
  State<ButtonOptions> createState() => _ButtonOptionsState();
}

class _ButtonOptionsState extends State<ButtonOptions> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => const MenuItems(),
        width: 250,
        height: 355.7
    ),
    child: const Icon(Icons.more_vert));
  }
}