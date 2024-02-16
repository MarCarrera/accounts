import 'package:fitness/view/utils/show_add_payment.dart';
import 'package:fitness/view/utils/show_delete_user.dart';
import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class SettingRow extends StatelessWidget {
  final String idPago;
  final String paymentDate;
  final String nameUser;
  final String paymentAmount;
  final VoidCallback onPressed;
  const SettingRow(
      {super.key,
      required this.onPressed,
      required this.paymentDate,
      required this.nameUser,
      required this.paymentAmount,
      required this.idPago});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
                paymentDate,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            Expanded(
              child: Text(
                nameUser == 'null' ? 'Sin nombre' : nameUser,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            Expanded(
              child: Text(
                paymentAmount,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 19,
                ),
              ),
            ),
            DeleteButton(context, idPago),
          ],
        ),
      ),
    );
  }

  SizedBox DeleteButton(
    BuildContext context,
    String idPago,
  ) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
            onPressed: () {
              print('eliminando pago...');

              ShowCleanDataUser().showDeleteDialog(context, idPago);
            },
            padding: EdgeInsets.zero,
            height: 30,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            textColor: TColor.primaryColor1,
            minWidth: double.maxFinite,
            elevation: 0,
            color: Colors.transparent,
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.white,
              size: 20,
            )),
      ),
    );
  }
}
