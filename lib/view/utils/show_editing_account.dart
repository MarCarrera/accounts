import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/utils/text_dorm.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ShowEditingAccount {
  Future<void> showEditAccount(
      BuildContext context,
      double responsiveHeight,
      String idAccount,
      String password,
      TextEditingController passController) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Editar contraseña",
                style: TextStyle(
                    fontSize: 24,
                    color: TColor.primaryColor1,
                    fontWeight: FontWeight.w700),
              ),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(height: 30, color: TColor.primaryColor2),
                      TextForm(
                          controller: passController,
                          text: password,
                          icon: Icons.security),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      //}
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                          fontSize: 20,
                          color: TColor.primaryColor2,
                          fontWeight: FontWeight.w700),
                    )),
                TextButton(
                    onPressed: () async {},
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await QuickAlert.show(
                            context: context,
                            type: QuickAlertType.info,
                            title: 'Actualizar contraseña',
                            text: 'Nueva contraseña: ${passController.text}',
                            textColor: TColor.secondaryColor1,
                            titleColor: TColor.secondaryColor1,
                            confirmBtnText: 'Confirmar',
                            confirmBtnColor: TColor.secondaryColor2,
                            onConfirmBtnTap: () async {
                              //request para actualizar los datos de usuario en Firebase
                              await updateAccountData(
                                  idAccount: idAccount,
                                  password: passController.text);
                              //limpiar controladores de data usuario
                              //cleanDataUser();

                              //actualiza datos de Firebase en vista
                              //uploadData(idAccount);
                              Navigator.of(context).pop();
                            },
                          );
                          leadingImage:
                          'assets/info.gif';
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        "Actualizar",
                        style: TextStyle(
                            fontSize: 20,
                            color: TColor.primaryColor2,
                            fontWeight: FontWeight.w700),
                      ),
                    ))
              ],
            );
          });
        });
  }

  /*cleanDataUser() {
    nameController.clear();
    paymentController.clear();
    phoneController.clear();
    pinController.clear();
    //statusController.clear();
  }*/
}
