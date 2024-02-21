// ignore_for_file: no_logic_in_create_state

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
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

class FinishedWorkoutView extends StatefulWidget {
  const FinishedWorkoutView(
      {super.key,
      required this.idAccount,
      required this.userName,
      required this.idUser,
      required this.paymentDate,
      required this.profileUser,
      required this.amountUser,
      required this.phoneUser,
      required this.pinUser,
      required this.statusUser,
      required this.genreUser,
      required this.account,
      required this.pass});
  final String idAccount;
  final String userName;
  final String idUser;
  final String paymentDate;
  final String profileUser;
  final String amountUser;
  final String phoneUser;
  final String pinUser;
  final String statusUser;
  final String genreUser;
  final String account;
  final String pass;

  @override
  State<FinishedWorkoutView> createState() => _FinishedWorkoutViewState(
      idAccount,
      userName,
      idUser,
      paymentDate,
      profileUser,
      amountUser,
      phoneUser,
      pinUser,
      statusUser,
      genreUser,
      account,
      pass);
}

class _FinishedWorkoutViewState extends State<FinishedWorkoutView> {
  _FinishedWorkoutViewState(
    this.idAccount,
    this.userName,
    this.idUser,
    this.paymentDate,
    this.profileUser,
    this.amountUser,
    this.phoneUser,
    this.pinUser,
    this.statusUser,
    this.genreUser,
    this.account,
    this.pass,
  );
  final String idAccount;
  final String userName;
  final String idUser;
  final String paymentDate;
  final String profileUser;
  final String amountUser;
  final String phoneUser;
  final String pinUser;
  final String statusUser;
  final String genreUser;
  final String account;
  final String pass;

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
  List<String> arrayIdPayments = [];
  List<String> paymentDateUserA = [];
  List<String> arrayPaymentStatusA = [];
  List<String> arrayPaymentAmountA = [];

  // List<String> paymentDateUserB = [];
  // List<String> arrayPaymentStatusB = [];
  // List<String> arrayPaymentAmountB = [];
  // List<String> paymentDateUserC = [];
  // List<String> arrayPaymentStatusC = [];
  // List<String> arrayPaymentAmountC = [];
  // List<String> paymentDateUserD = [];
  // List<String> arrayPaymentStatusD = [];
  // List<String> arrayPaymentAmountD = [];
  // List<String> paymentDateUserE = [];
  // List<String> arrayPaymentStatusE = [];
  // List<String> arrayPaymentAmountE = [];
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

  //calcular dias para proximo pago----------------------
  String calcularProxPago(String paymentDay) {
    //fecha actual
    DateTime currentDate = DateTime.now();
    print('currentDate::: $currentDate');
    //dia de pago
    int day;
    if (paymentDate.isEmpty || paymentDay == '') {
      day = 19;
    } else {
      day = int.parse(paymentDay);
      print('day::: $day');
    }

    DateTime fechaObjetivo;
    //si el dia actual es posterior al dia de pago del mes actual, se avanza al sig mes para calcular los dias restantes
    if (currentDate.day > day) {
      //ultimo dia del mes actual
      DateTime lastDate =
          DateTime.utc(currentDate.year, currentDate.month + 1, 0);
      print('lastDate::: $lastDate');

      currentDate = currentDate.add(Duration(days: lastDate.day));
      print('currentDate cambiado::: $currentDate');
      // Crear la fecha objetivo del próximo mes
      fechaObjetivo =
          DateTime.utc(currentDate.year, currentDate.month + 1, day);
    } else {
      fechaObjetivo = DateTime.utc(currentDate.year, currentDate.month, day);
    }
    print('fechaObjetivo ::: $fechaObjetivo');
    // Calcular la diferencia en días
    String diasFaltantes =
        fechaObjetivo.difference(currentDate).inDays.toString();
    print('diasFaltantes ::: $diasFaltantes');

    if (diasFaltantes == '0') {
      return 'Hoy';
    } else if (diasFaltantes == '1') {
      //mostrarNotificacion();
      return "Mañana";
    } else {
      if (diasFaltantes == '-1') {
        //mostrarNotificacion();
        return "Ayer";
      } else {
        return diasFaltantes;
      }
    }
  }

  //pagos de usuario--------------------------------------------------
  Future<void> obtenerPagosUsuario(String idUser) async {
    var response = await getPaymentsProfilesByUser(idUser);
    if (response != "err_internet_conex") {
      //print('Respuesta pagos:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          arrayIdPayments.clear();
          paymentDateUserA.clear();
          arrayPaymentStatusA.clear();
          arrayPaymentAmountA.clear();

          if (paymentDateUserA.isEmpty &&
              arrayPaymentStatusA.isEmpty &&
              arrayPaymentAmountA.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              arrayIdPayments.add(response[i]['idPago'].toString());
              paymentDateUserA.add(response[i]['paymentDate'].toString());
              arrayPaymentStatusA.add(response[i]['paymentStatus'].toString());
              arrayPaymentAmountA.add(response[i]['amountPay'].toString());
              double? amountPayA = double.tryParse(response[i]['amountPay']);
              totalPagado += amountPayA ?? 0.0;
            }
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }

  Future<void> handleRefreshFunction() async {
    print('Refresh_Done');
    obtenerPagosUsuario(idUser);
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    obtenerPagosUsuario(idUser);
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
                    //CONTENEDOR DE TARJETA O CARD DE PAGOS
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Usuario: $userName",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              AddButton(context, idUser, idAccount,
                                  paymentDateController, amountPayController),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetCell(
                                  icon: "assets/icons/dinero.png",
                                  value: totalPagado.toString(),
                                  title: "Total Pagado",
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TodayTargetCell(
                                  icon: "assets/icons/pago2.png",
                                  value: calcularProxPago(paymentDate) ==
                                              'Hoy' ||
                                          calcularProxPago(paymentDate) ==
                                              'Mañana'
                                      ? calcularProxPago(paymentDate)
                                      : '${calcularProxPago(paymentDate)} dias',
                                  title: "Próximo pago",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //LISTA DE PAGOS-------------------------------
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: paymentDateUserA.length,
                            itemBuilder: (context, index) {
                              return SettingRow(
                                onPressed: () {
                                  print(
                                      'seleccionado:::: ${paymentDateUserA[index]}');
                                },
                                paymentDate: paymentDateUserA[index],
                                nameUser: arrayPaymentStatusA[index],
                                paymentAmount: arrayPaymentAmountA[index],
                                idPago: arrayIdPayments[index],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    //CONTENEDOR DE DATOS DE USUARIO
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Datos de Perfil",
                                style: TextStyle(
                                    color: TColor.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              ButtonOptions(
                                phoneUser: phoneUser,
                                idUser: idUser,
                                account: account,
                                pass: pass,
                                profile: profileUser,
                                pin: pinUser,
                                nameController: nameController,
                                paymentController: paymentController,
                                phoneController: phoneController,
                                genreController: genreController,
                                statusController: statusController,
                                pinController: pinController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/account.png",
                                  value: account,
                                  title: "Cuenta:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/proteger.png",
                                  value: pass,
                                  title: "Contraseña:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: genreUser == 'f'
                                      ? 'assets/icons/mujer.png'
                                      : genreUser == 'm'
                                          ? 'assets/icons/hombre.png'
                                          : 'assets/icons/desconocido.png',
                                  value: profileUser,
                                  title: "Usuario:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/candado.png",
                                  value: pinUser,
                                  title: "Pin:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/nombre.png",
                                  value: userName == '' ? 'Vacio' : userName,
                                  title: "Nombre:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/phone.png",
                                  value: phoneUser == '' ? 'Vacio' : phoneUser,
                                  title: "Telefono:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/pago2.png",
                                  value:
                                      paymentDate == '' ? 'Vacio' : paymentDate,
                                  title: "Mensualidad:",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TodayTargetFourCell(
                                  icon: "assets/icons/dinero.png",
                                  value:
                                      amountUser == '' ? 'Vacio' : amountUser,
                                  title: "Monto:",
                                ),
                              ),
                            ],
                          ),
                          /*OptionsUser(
                              context,
                              responsiveWidth,
                              idUser,
                              userName,
                              paymentDate,
                              amountUser,
                              phoneUser,
                              pinUser,
                              statusUser,
                              genreUser),*/
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
              obtenerPagosUsuario(idUser);
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
              obtenerPagosUsuario(idUser);
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
