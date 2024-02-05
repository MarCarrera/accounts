import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/utils/text_dorm.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:quickalert/quickalert.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
NepaliDateTime? _selectedDateTime = NepaliDateTime.now();
bool _showTimerPicker = false;
DateOrder _dateOrder = DateOrder.mdy;

String _design = 'm';
DateTime d = DateTime.now();
String formattedDate = '';

class ShowAddPayment {
  Future<void> showAddPayment(
      BuildContext context,
      //double responsiveWidth,
      String idUser,
      String idAccount,
      TextEditingController paymentDateController,
      //TextEditingController paymentStatusController,
      TextEditingController amountPayController) async {
    return await showDialog(
        context: context,
        builder: (context) {
          //bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Agregar pago",
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
                      InkWell(
                        onTap: () async {
                          final result = await showBoardDateTimePicker(
                            context: context,
                            pickerType: DateTimePickerType.datetime,
                            options: const BoardDateTimeOptions(
                              languages: BoardPickerLanguages.en(),
                              startDayOfWeek: DateTime.sunday,
                              pickerFormat: PickerFormat.ymd,
                              boardTitle: 'Board Picker',
                              pickerSubTitles:
                                  BoardDateTimeItemTitles(year: 'year'),
                            ),
                            onResult: (val) {},
                          );
                          /*if (result != null) {
                            setState(() => d = result);
                          }*/
                          if (result != null) {
                            setState(() {
                              d = result;
                              formattedDate =
                                  BoardDateFormat('yyyy-MM-dd').format(d);
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          child: Row(
                            children: [
                              Material(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                child: const SizedBox(
                                  height: 36,
                                  width: 36,
                                  child: Center(
                                    child: Icon(
                                      Icons.domain_verification_rounded,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  formattedDate,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      /*TextForm(
                          controller: paymentStatusController,
                          text: 'Estado',
                          icon: Icons.star_rate_rounded),*/
                      const SizedBox(height: 10),
                      TextForm(
                          controller: amountPayController,
                          text: 'Monto',
                          icon: Icons.monetization_on),
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
                            title: 'Agregar nuevo pago',
                            text:
                                'Fecha de Pago: $formattedDate \nMonto: ${amountPayController.text} ',
                            textColor: TColor.secondaryColor1,
                            titleColor: TColor.secondaryColor1,
                            confirmBtnText: 'Confirmar',
                            confirmBtnColor: TColor.secondaryColor1,
                            onConfirmBtnTap: () async {
                              //request para actualizar los datos de usuario en Firebase
                              await addPaymentProfileData(
                                  idUser: idUser,
                                  idAccount: idAccount,
                                  paymentDate: formattedDate,
                                  amountPay: amountPayController.text);
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
