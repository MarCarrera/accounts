import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/utils/text_dorm.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ShowInputDialog {
  Future<void> showInputDialog(
    BuildContext context,
    double responsiveWidth,
    String idUser,
    TextEditingController nameController,
    TextEditingController paymentController,
    TextEditingController phoneController,
    TextEditingController pinController,
    TextEditingController genreController,
    TextEditingController statusController,
    TextEditingController amountController,
    TextEditingController idAccountUserController,
    TextEditingController profileUserController,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Agregar usuario",
                style: TextStyle(
                    fontSize: 24,
                    color: TColor.secondaryColor1,
                    fontWeight: FontWeight.w700),
              ),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(height: 30, color: TColor.secondaryColor1),
                      TextForm(
                          controller: idAccountUserController,
                          text: 'Cuenta',
                          icon: Icons.person_2),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: profileUserController,
                          text: 'Perfil',
                          icon: Icons.person_2),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: nameController,
                          text: 'Nombre',
                          icon: Icons.person_2),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: paymentController,
                          text: 'Mensualidad',
                          icon: Icons.calendar_month),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: amountController,
                          text: 'Monto',
                          icon: Icons.monetization_on),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: phoneController,
                          text: 'Telefono',
                          icon: Icons.phone_android),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: pinController,
                          text: 'Pin',
                          icon: Icons.password),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: genreController,
                          text: 'Género',
                          icon: Icons.person_2_outlined),
                      const SizedBox(height: 10),
                      TextForm(
                          controller: statusController,
                          text: 'Estado',
                          icon: Icons.check_box),
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
                          color: TColor.secondaryColor1,
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
                            title: 'Confirmar usuario',
                            text:
                                'Inicio de Mensualidad: ${paymentController.text} \nTeléfono: ${phoneController.text} \nCuentaNetflix00A@gmail.com \nUsuario: A \nPin: ${pinController.text} ',
                            textColor: TColor.secondaryColor1,
                            titleColor: TColor.secondaryColor1,
                            confirmBtnText: 'Confirmar',
                            confirmBtnColor: TColor.secondaryColor1,
                            onConfirmBtnTap: () async {
                              print('datos guardados');
                              //request para guardar los datos de usuario en Firebase
                              await addProfileData(
                                  profileUser: profileUserController.text,
                                  nameUser: nameController.text,
                                  paymentDateUser: paymentController.text,
                                  amount: amountController.text,
                                  phoneUser: phoneController.text,
                                  pinUser: pinController.text,
                                  statusUser: statusController.text,
                                  idAccountUser: idAccountUserController.text,
                                  genre: genreController.text);
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
                        "Agregar",
                        style: TextStyle(
                            fontSize: 20,
                            color: TColor.secondaryColor1,
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
