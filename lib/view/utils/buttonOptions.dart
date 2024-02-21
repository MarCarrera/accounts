// ignore_for_file: no_logic_in_create_state

import 'package:expandable_fab_menu/expandable_fab_menu.dart';
import 'package:fitness/view/utils/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ButtonOptions extends StatefulWidget {
  const ButtonOptions(
      {super.key,
      required this.phoneUser,
      required this.idUser,
      required this.account,
      required this.pass,
      required this.profile,
      required this.pin,
      required this.nameController,
      required this.paymentController,
      required this.phoneController,
      required this.genreController,
      required this.statusController,
      required this.pinController});
  final String phoneUser;
  final String idUser;
  final String account;
  final String pass;
  final String profile;
  final String pin;

  final TextEditingController nameController;
  final TextEditingController paymentController;
  final TextEditingController phoneController;
  final TextEditingController genreController;
  final TextEditingController statusController;
  final TextEditingController pinController;

  @override
  State<ButtonOptions> createState() => _ButtonOptionsState(
      phoneUser,
      idUser,
      account,
      pass,
      profile,
      pin,
      nameController,
      paymentController,
      phoneController,
      genreController,
      statusController,
      pinController);
}

class _ButtonOptionsState extends State<ButtonOptions> {
  _ButtonOptionsState(
      this.phoneUser,
      this.idUser,
      this.account,
      this.pass,
      this.profile,
      this.pin,
      this.nameController,
      this.paymentController,
      this.phoneController,
      this.genreController,
      this.statusController,
      this.pinController);
  final String phoneUser;
  final String idUser;
  final String account;
  final String pass;
  final String profile;
  final String pin;

  final TextEditingController nameController;
  final TextEditingController paymentController;
  final TextEditingController phoneController;
  final TextEditingController genreController;
  final TextEditingController statusController;
  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showPopover(
            context: context,
            bodyBuilder: (context) => MenuItems(
                  phoneUser: phoneUser,
                  idUser: idUser,
                  account: account,
                  pass: pass,
                  profile: profile,
                  pin: pin,
                  nameController: nameController,
                  paymentController: paymentController,
                  phoneController: phoneController,
                  genreController: genreController,
                  statusController: statusController,
                  pinController: pinController,
                ),
            width: 250,
            height: 305.4),
        child: const Icon(Icons.more_vert));
  }
}
