// ignore_for_file: no_logic_in_create_state

import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class WorkoutRow extends StatefulWidget {
  const WorkoutRow({
    super.key,
    required this.idUser,
    required this.profileUser,
    required this.nameUser,
    required this.paymentUser,
    required this.amountUser,
    required this.phoneUser,
    required this.pinUser,
    required this.statusUser,
    required this.genreUser,
  });
  final String idUser;
  final String profileUser;
  final String nameUser;
  final String paymentUser;
  final String amountUser;
  final String phoneUser;
  final String pinUser;
  final String statusUser;
  final String genreUser;

  @override
  State<WorkoutRow> createState() => _WorkoutRowState(
      idUser,
      profileUser,
      nameUser,
      paymentUser,
      amountUser,
      phoneUser,
      pinUser,
      statusUser,
      genreUser);
}

class _WorkoutRowState extends State<WorkoutRow> {
  _WorkoutRowState(
      this.idUser,
      this.profileUser,
      this.nameUser,
      this.paymentUser,
      this.amountUser,
      this.phoneUser,
      this.pinUser,
      this.statusUser,
      this.genreUser);
  final String idUser;
  final String profileUser;
  final String nameUser;
  final String paymentUser;
  final String amountUser;
  final String phoneUser;
  final String pinUser;
  final String statusUser;
  final String genreUser;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(genreUser == 'f'
                    ? 'assets/icons/mujer.png'
                    : genreUser == 'm'
                        ? 'assets/icons/hombre.png'
                        : 'assets/icons/hombre2.png'),
              ),

              /*Image.asset(
                wObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),*/
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameUser.toString() == 'null'
                    ? Text(
                        'Usuario: ${profileUser.toUpperCase()}  Sin nombre',
                        style: TextStyle(color: TColor.black, fontSize: 18),
                      )
                    : Text(
                        'Usuario: ${profileUser.toUpperCase()}  Nombre: $nameUser',
                        style: TextStyle(color: TColor.black, fontSize: 18),
                      ),
                Text(
                  "Teléfono: $phoneUser",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Estado: $statusUser",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Fecha de Pago: $paymentUser",
                  style: TextStyle(
                    color: TColor.gray,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/next_icon.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
