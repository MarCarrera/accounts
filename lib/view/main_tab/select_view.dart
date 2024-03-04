// ignore_for_file: no_logic_in_create_state

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fitness/common_widget/all_money.dart';
import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/today_target_cell.dart';
import 'package:fitness/common_widget/today_target_four_cell.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/home/notification_view.dart';
import 'package:fitness/view/utils/buttonOptions.dart';
import 'package:fitness/view/utils/show_add_payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/colo_extension.dart';
import 'package:expandable_fab_menu/expandable_fab_menu.dart';

class SelectView extends StatefulWidget {
  const SelectView({
    super.key,
  });

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  _SelectViewState();

  DateTime d = DateTime.now();
  String valueText = '';
  String startDate = '';
  String endDate = '';
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime.now(),
  ];
  double totalPagado = 0.0;

  String date1 = DateFormat('yyyy-MM-dd')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

  String date2 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //pagos de usuarios cuenta A-----------------------------------
  List<String> arrayIdTrans = [];
  List<String> arrayReason = [];
  List<String> arrayTransaction = [];
  List<String> arrayDate = [];
  List<String> arrayAmount = [];
  List<String> arrayStatus = [];
  List<String> arrayIdAccount = [];
  List<String> arrayAmountMoney = [];
  List<String> arrayDescription = [];
  List<String> arrayIdMoney = [];

  //CONTROLADORES----------------------------------------------------------------
  final TextEditingController nameController = TextEditingController();

  final TextEditingController paymentController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController genreController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController pinController = TextEditingController();

  final TextEditingController statusController = TextEditingController();

  final TextEditingController idAccountUserController = TextEditingController();

  final TextEditingController profileUserController = TextEditingController();
  /////------------------------------------------------------------------------
  ///final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController paymentDateController = TextEditingController();
  final TextEditingController paymentStatusController = TextEditingController();
  final TextEditingController amountPayController = TextEditingController();

  //pagos de usuario--------------------------------------------------
  Future<void> obtenerTransacciones() async {
    var response = await getTransactions();
    if (response != "err_internet_conex") {
      print('Respuesta transacciones:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          arrayIdTrans.clear();
          arrayReason.clear();
          arrayTransaction.clear();
          arrayDate.clear();
          arrayAmount.clear();
          arrayStatus.clear();
          arrayIdAccount.clear();

          if (arrayIdTrans.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              arrayIdTrans.add(response[i]['idTrans'].toString());
              arrayReason.add(response[i]['reason'].toString());
              arrayTransaction.add(response[i]['transaction'].toString());
              arrayDate.add(response[i]['date'].toString());
              arrayAmount.add(response[i]['amount'].toString());
              arrayStatus.add(response[i]['status'].toString());
              arrayIdAccount.add(response[i]['idAccount'].toString());
              //double? amountPayA = double.tryParse(response[i]['amount']);
              //totalPagado += amountPayA ?? 0.0;
            }
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }

  Future<void> obtenerDinero() async {
    var response = await getAllMoney();
    if (response != "err_internet_conex") {
      print('Respuesta dinero:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          arrayIdMoney.clear();
          arrayDescription.clear();
          arrayAmountMoney.clear();

          if (arrayDescription.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              arrayIdMoney.add(response[i]['idMoney'].toString());
              arrayDescription.add(response[i]['description'].toString());
              arrayAmountMoney.add(response[i]['amount'].toString());
            }
          }
          print(arrayDescription);
          print(arrayAmountMoney);
        }
      });
    } else {
      print('Sin conexion');
    }
  }

  Future<void> handleRefreshFunction() async {
    print('Refresh_Done');
    obtenerTransacciones();
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    obtenerTransacciones();
    obtenerDinero();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double responsiveWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LiquidPullToRefresh(
        height: 100,
        color: TColor.secondaryColor2,
        backgroundColor: Color(0xFFD6E4E5),
        animSpeedFactor: 4,
        showChildOpacityTransition: false,
        onRefresh: handleRefreshFunction,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildCalendarDialogButton(),
                        DateButton(),
                        SearchButton(),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    //CONTENEDOR DE TARJETA O CARD DE PAGOS -----------------------------
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          TColor.primaryColor2.withOpacity(0.3),
                          TColor.primaryColor1.withOpacity(0.3)
                        ]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          //LISTA DE PAGOS-------------------------------
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: arrayIdMoney.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  AllMoney(
                                    icon: "assets/icons/dinero.png",
                                    value: arrayAmountMoney[index],
                                    title: arrayDescription[index],
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    //CONTENEDOR DE TARJETA O CARD DE PAGOS -----------------------------
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          TColor.primaryColor2.withOpacity(0.3),
                          TColor.primaryColor1.withOpacity(0.3)
                        ]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          //LISTA DE PAGOS-------------------------------
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: arrayIdTrans.length,
                            itemBuilder: (context, index) {
                              return SettingRow(
                                onPressed: () {
                                  print(
                                      'seleccionado:::: ${arrayIdTrans[index]}');
                                },
                                paymentDate: arrayDate[index],
                                nameUser: arrayTransaction[index],
                                paymentAmount: arrayAmount[index],
                                idPago: arrayIdTrans[index],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox DateButton() {
    return SizedBox(
      width: 250,
      height: 50,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: TColor.primaryG,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: MaterialButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            height: 30,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            textColor: Colors.white,
            minWidth: double.maxFinite,
            elevation: 0,
            color: Colors.transparent,
            child: Text(
              startDate == '' ? '$date1 a $date2' : '$startDate a $endDate',
              style: const TextStyle(fontSize: 18),
            ),
          )),
    );
  }

  SizedBox SearchButton() {
    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
            onPressed: () {
              print('fechas seleccionadas:::: $startDate y $endDate');
              print('obteniendo pagos usuario...');
              //obtenerTransacciones();
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
              Icons.search,
              color: Colors.white,
              size: 30,
            )),
      ),
    );
  }

  SizedBox AddButton(
    BuildContext context,
    String idUser,
    String idAccount,
    TextEditingController paymentDateController,
    TextEditingController amountPayController,
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
              print('Agregando pago...');

              ShowAddPayment().showAddPayment(context, idUser, idAccount,
                  paymentDateController, amountPayController);
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
              Icons.add,
              color: Colors.white,
              size: 20,
            )),
      ),
    );
  }

  SizedBox OptionsButton() {
    var media = MediaQuery.of(context).size;
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
              print('fechas seleccionadas:::: $startDate y $endDate');
              print('obteniendo pagos usuario...');
              //obtenerPagosUsuario(idUser);
            },
            padding: EdgeInsets.zero,
            height: 30,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            textColor: TColor.primaryColor1,
            minWidth: double.maxFinite,
            elevation: 0,
            color: Colors.transparent,
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 20,
            )),
      ),
    );
  }

  buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.purple[800],
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
    ) {
      values =
          values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
      valueText = (values.isNotEmpty ? values[0] : null)
          .toString()
          .replaceAll('00:00:00.000', '');

      if (datePickerType == CalendarDatePicker2Type.multi) {
        valueText = values.isNotEmpty
            ? values
                .map((v) => v.toString().replaceAll('00:00:00.000', ''))
                .join(', ')
            : 'null';
      } else if (datePickerType == CalendarDatePicker2Type.range) {
        if (values.isNotEmpty) {
          startDate = values[0].toString().replaceAll('00:00:00.000', '');
          endDate = values.length > 1
              ? values[1].toString().replaceAll('00:00:00.000', '')
              : 'null';
          valueText = '$startDate to $endDate';
        } else {
          return 'null';
        }
      }

      return valueText;
    }

    return SizedBox(
      width: 50,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.primaryG,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(30),
                value: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white,
              );
              if (values != null) {
                print(_getValueText(
                  config.calendarType,
                  values,
                ));
                print('fecha1:::: $startDate, fecha2::::: $endDate');
                setState(() {
                  _dialogCalendarPickerValue = values;
                });
              }
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
              Icons.calendar_month,
              color: Colors.white,
              size: 30,
            )),
      ),
    );
  }

  /*Positioned OptionsUser(
    BuildContext context,
    double responsiveWidth,
    String idUser,
    String nameUser,
    String payment,
    String amount,
    String phone,
    String pin,
    String status,
    String genre,
  ) {
    return Positioned(
        top: 150.0,
        left: 250.0,
        right: 0.0,
        child: ExpandableMenu(
          width: 40.0,
          height: 40.0,
          backgroundColor: Colors.white.withOpacity(0.8),
          iconColor: TColor.secondaryColor1,
          items: [
            GestureDetector(
              onTap: () async {
                // print("enviar mensaje");
                await shareMessageUser(phone, 'mensaje de prueba');
              },
              child: Icon(
                Icons.email,
                color: TColor.secondaryColor1,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("editar usuario");
                ShowEditingDialog().showEditDialog(
                    context,
                    responsiveWidth,
                    idUser,
                    nameUser,
                    payment,
                    phone,
                    pin,
                    amount,
                    genre,
                    status,
                    nameController,
                    paymentController,
                    amountController,
                    genreController,
                    phoneController,
                    statusController,
                    pinController);
              },
              child: Icon(
                Icons.edit,
                color: TColor.secondaryColor1,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("compartir usuario");
                
              },
              child: Icon(
                Icons.share,
                color: TColor.secondaryColor1,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("liberar usuario");
                ShowCleanDataUser().showCleanDataDialog(context, idUser);
              },
              child: Icon(
                Icons.cleaning_services_rounded,
                color: TColor.secondaryColor1,
              ),
            ),
            GestureDetector(
              onTap: () {
                print("eliminar usuario");
                ShowCleanDataUser().showDeleteDialog(context, idUser);
              },
              child: Icon(
                Icons.delete,
                color: TColor.secondaryColor1,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }*/
}
