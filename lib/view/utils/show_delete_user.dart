// ignore_for_file: use_build_context_synchronously

import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/request/api_request.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ShowCleanDataUser {
  Future<void> showCleanDataDialog(BuildContext context, String idUser) async {
    return
        // var dialogConfirm = QuickAlert.show;

        await QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Confirmación',
      titleColor: TColor.secondaryColor1,
      text: '¿Quieres liberar éste usuario?',
      textColor: TColor.secondaryColor1,
      confirmBtnText: 'Si, liberar',
      confirmBtnColor: TColor.secondaryColor1,
      //autoCloseDuration: const Duration(seconds: 2),
      onConfirmBtnTap: () async {
        //eliminar usuario de perfil
        await updateDateProfileData(idUser: idUser);

        //recarga de datos desde firebase
        //uploadData(idAccount);

        //Navigator.of(context).pop();

        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Usuario Liberado!',
          textColor: TColor.secondaryColor1,
          autoCloseDuration: const Duration(seconds: 2),
          showConfirmBtn: false,
          title: 'Liberado',
        );
        leadingImage:
        'assets/success.gif';
        Navigator.of(context).pop();
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  Future<void> showDeleteDialog(BuildContext context, String idPago) async {
    return
        // var dialogConfirm = QuickAlert.show;

        await QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: 'Confirmación',
      titleColor: TColor.secondaryColor1,
      text: '¿Quieres eliminar éste pago?',
      textColor: TColor.secondaryColor1,
      confirmBtnText: 'Si, eliminar',
      confirmBtnColor: TColor.secondaryColor1,
      //autoCloseDuration: const Duration(seconds: 2),
      onConfirmBtnTap: () async {
        //eliminar usuario de perfil
        await deletePaymentByPay(idPago: idPago);

        //recarga de datos desde firebase
        //uploadData(idAccount);

        //Navigator.of(context).pop();

        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Pago Eliminado!',
          textColor: TColor.secondaryColor1,
          autoCloseDuration: const Duration(seconds: 2),
          showConfirmBtn: false,
          title: 'Eliminado',
        );
        leadingImage:
        'assets/success.gif';
        Navigator.of(context).pop();
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }
}
