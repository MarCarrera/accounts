import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/utils/show_delete_user.dart';
import 'package:fitness/view/utils/show_input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItems extends StatefulWidget {
  const MenuItems(
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
      required this.statusController});
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

  @override
  State<MenuItems> createState() => _MenuItemsState(
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
      statusController);
}

class _MenuItemsState extends State<MenuItems> {
  _MenuItemsState(
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
      this.statusController);
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

  Future<void> shareMessageUser(String phoneUser) async {
    String phoneNumber = '+52$phoneUser';
    String saludo = obtenerSaludo();
    String message =
        '$saludo, solo para recordarle del pago de la mensualidad de Netflix porfavor...';
    String whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    await launch(whatsappUrl);
  }

  Future<void> shareAccountData(
      String phoneUser, String account, String pass) async {
    String phoneNumber = '+52$phoneUser';
    String message = 'DATOS Cuenta::: $account, Contraseña::: $pass';
    String whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    await launch(whatsappUrl);
  }

  Future<void> shareProfileData(
      String phoneUser, String profile, String pin) async {
    String phoneNumber = '+52$phoneUser';
    String message = 'DATOS Perfil::: ${profile.toUpperCase()}, Pin::: $pin';
    String whatsappUrl =
        'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
    await launch(whatsappUrl);
  }

  String obtenerSaludo() {
    DateTime ahora = DateTime.now();
    int hora = ahora.hour;

    if (hora >= 5 && hora < 12) {
      return 'Buenos días';
    } else if (hora >= 12 && hora < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            print('enviar datos cuenta:::');
            await shareAccountData(phoneUser, account, pass);
          },
          child: Container(
            height: 50,
            width: 250,
            color: TColor.primaryColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Enviar cuenta',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.white,
          height: 0.8,
        ),
        GestureDetector(
          onTap: () async {
            print('enviar datos perfil:::');
            await shareProfileData(phoneUser, profile, pin);
          },
          child: Container(
            height: 50,
            width: 250,
            color: TColor.primaryColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Enviar perfil',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white, height: 0.8),
        GestureDetector(
          onTap: () {
            print('actualizando datos');
            ShowInputDialog().showInputDialog(
                context,
                idUser,
                nameController,
                paymentController,
                phoneController,
                genreController,
                statusController);
          },
          child: Container(
            height: 50,
            width: 250,
            color: TColor.primaryColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Actualizar',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white, height: 0.8),
        Container(
          height: 50,
          width: 250,
          color: TColor.primaryColor1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Editar pin',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
        Divider(color: Colors.white, height: 0.8),
        GestureDetector(
          onTap: () {
            print("liberar usuario");
            ShowCleanDataUser().showCleanDataDialog(context, idUser);
          },
          child: Container(
            height: 50,
            width: 250,
            color: TColor.primaryColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Liberar perfil',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white, height: 0.8),
        GestureDetector(
          onTap: () async {
            print('enviar mensaje:::');
            await shareMessageUser(phoneUser);
          },
          child: Container(
            height: 50,
            width: 250,
            color: TColor.primaryColor1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Recordatorio',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
        Divider(color: Colors.white, height: 0.8),
      ],
    );
  }
}
