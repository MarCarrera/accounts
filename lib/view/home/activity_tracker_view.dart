// ignore_for_file: no_logic_in_create_state

import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/today_target_two_cell.dart';
import 'package:fitness/common_widget/workout_row.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/home/finished_workout_view.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fitness/view/utils/show_input_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/today_target_cell.dart';

class ActivityTrackerView extends StatefulWidget {
  const ActivityTrackerView(
      {super.key,
      required this.idAccount,
      required this.accountName,
      required this.pass});

  final String idAccount;
  final String accountName;
  final String pass;

  @override
  State<ActivityTrackerView> createState() =>
      _ActivityTrackerViewState(idAccount, accountName, pass);
}

class _ActivityTrackerViewState extends State<ActivityTrackerView> {
  //CONSTRUCTOR DE CLASE PARA HACER USO DE LAS VARIABLES COMPARTIDAS
  _ActivityTrackerViewState(this.idAccount, this.accountName, this.pass);
  final String idAccount;
  final String accountName;
  final String pass;

  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  int touchedIndex = -1;

  List latestArr = [
    {
      "image": "assets/img/pic_4.png",
      "title": "Drinking 300ml Water",
      "time": "About 1 minutes ago"
    },
    {
      "image": "assets/img/pic_5.png",
      "title": "Eat Snack (Fitbar)",
      "time": "About 3 hours ago"
    },
  ];

  DateTime d = DateTime.now();
  String valueText = '';
  String startDate = '';
  String endDate = '';
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(DateTime.now().year, DateTime.now().month, 1),
    DateTime.now(),
  ];

  String date1 = DateFormat('yyyy-MM-dd')
      .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

  String date2 = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //pagos de usuarios cuenta -----------------------------------
  List<String> arrayIdPayments = [];
  List<String> paymentDateAccountA = [];
  List<String> arrayNameUsersAccountA = [];
  List<String> arrayPaymentAmountA = [];
  List<String> arrayTransactions = [];
  bool showDataPaymentA = false;
  List<double> arrayTotalPay = [];
  double totalPagado = 0.0;
  double total = 0.0;
  double ganancia = 0.0;
  double liquidar = 0.0;
  double envio = 0.0;
  double enviado = 0.0;
  double retiro = 0.0;
  //Perfiles de usuarios
  List<String> arrayidUserA = [];
  List<String> arrayprofileA = [];
  List<String> arraynameA = [];
  List<String> arraypaymentA = [];
  List<String> arrayamountA = [];
  List<String> arrayphoneA = [];
  List<String> arraypinA = [];
  List<String> arraystatusA = [];
  List<String> arrayGenresA = [];
  bool dataAccountAclear = false;

  //OBTENER PAGOS DE CUENTA-------------------------------
  Future<void> obtenerPagosCuenta(
      String idAccount, String date1, String date2) async {
    var response =
        await getPaymentsProfilesByAccountDate(idAccount, date1, date2);
    if (response != "err_internet_conex") {
      //print('Respuesta pagos cuenta :::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          arrayIdPayments.clear();
          paymentDateAccountA.clear();
          arrayNameUsersAccountA.clear();
          arrayPaymentAmountA.clear();
          totalPagado = 0.0;
          // arrayTotalPay.clear();

          if (paymentDateAccountA.isEmpty &&
              arrayNameUsersAccountA.isEmpty &&
              arrayPaymentAmountA.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              arrayIdPayments.add(response[i]['idPago'].toString());
              paymentDateAccountA.add(response[i]['paymentDate'].toString());
              arrayNameUsersAccountA.add(response[i]['nameUser'].toString());
              arrayPaymentAmountA.add(response[i]['amountPay'].toString());
              double? amountPayA = double.tryParse(response[i]['amountPay']);
              totalPagado += amountPayA ?? 0.0;
              ganancia = totalPagado - 299;
              liquidar = ganancia - total;
              if (totalPagado > 299) {
                envio = totalPagado - ganancia - enviado;
              }
            }
            arrayTotalPay.add(totalPagado);
            print("total pago a::::: $totalPagado ");
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }

  //OBTENER USUARIOS DE LA CUENTA ------------------------
  Future<void> obtenerPerfilesCuenta(String idAccount) async {
    var response = await getProfilesByAccount(idAccount);
    if (response != "err_internet_conex") {
      //print('Respuesta perfiles:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          for (int i = 0; i < response.length; i++) {
            String idAccountUser = response[i]['idAccountUser'].toString();
            arrayidUserA.add(response[i]['idUser'].toString());
            arrayprofileA.add(response[i]['profileUser'].toString());
            arraynameA.add(response[i]['nameUser'].toString());
            arraypaymentA.add(response[i]['paymentDateUser'].toString());
            arrayamountA.add(response[i]['amount'].toString());
            arrayphoneA.add(response[i]['phoneUser'].toString());
            arraypinA.add(response[i]['pinUser'].toString());
            arraystatusA.add(response[i]['statusUser'].toString());
            arrayGenresA.add(response[i]['genre'].toString());
          }
        }
        //  }
      });
    } else {
      print('Sin conexion');
    }
  }

  //OBTENER PAGOS DE CUENTA-------------------------------
  Future<void> obtenerTransaccionesCuenta(String idAccount) async {
    var response = await getTransaccionAccount(idAccount, date1, date2);
    if (response != "err_internet_conex") {
      print('Respuesta transacciones cuenta :::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          arrayTransactions.clear();
          total = 0.0;
          // arrayTotalPay.clear();

          if (paymentDateAccountA.isEmpty &&
              arrayNameUsersAccountA.isEmpty &&
              arrayPaymentAmountA.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              arrayTransactions.add(response[i]['amount'].toString());
              double? amountTran = double.tryParse(response[i]['amount']);
              total += amountTran ?? 0.0;
            }
            //arrayTotalPay.add(total);
            print("total transaccion::::: $total ");
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }

  Future<void> handleRefreshFunction() async {
    print('Refresh_Done');
    obtenerPagosCuenta(idAccount, date1, date2);
    obtenerPerfilesCuenta(idAccount);
    return await Future.delayed(Duration(seconds: 2));
  }

  //------------------------------------------------------
  @override
  void initState() {
    super.initState();
    obtenerPagosCuenta(idAccount, date1, date2);
    obtenerPerfilesCuenta(idAccount);
    obtenerTransaccionesCuenta(idAccount);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Control de Pagos",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: LiquidPullToRefresh(
        height: 100,
        color: TColor.secondaryColor2,
        backgroundColor: Color(0xFFD6E4E5),
        animSpeedFactor: 4,
        showChildOpacityTransition: false,
        onRefresh: handleRefreshFunction,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
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
                SizedBox(
                  height: 14,
                ),
                //CONTENEDOR DE TARJETA O CARD DE PAGOS
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                            "Cuenta: $accountName",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
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
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TodayTargetCell(
                              icon: "assets/icons/money.png",
                              value:
                                  ganancia < 0 ? '00.0' : ganancia.toString(),
                              title: "Ganancia",
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
                            child: GestureDetector(
                              onTap: () {
                                print('Agregando transaccion...');
                                ShowInputDialog().showAddTransaction(
                                    context,
                                    idAccount,
                                    reasonController,
                                    amountController);
                              },
                              child: TodayTargetTwoCell(
                                icon: "assets/icons/fondos.png",
                                value1:
                                    liquidar < 0 ? '00.0' : liquidar.toString(),
                                title1: "Pendiente",
                                value2: total.toString(),
                                title2: "Liquidado",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TodayTargetTwoCell(
                              icon: "assets/icons/bank.png",
                              value1: envio < 0 ? '00.0' : envio.toString(),
                              title1: "Pendiente",
                              value2: enviado.toString(),
                              title2: "Enviado",
                            ),
                          ),
                        ],
                      ),
                      //LISTA DE PAGOS-------------------------------
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: paymentDateAccountA.length,
                        itemBuilder: (context, index) {
                          return SettingRow(
                            onPressed: () {
                              print(
                                  'seleccionado:::: ${paymentDateAccountA[index]}');
                            },
                            paymentDate: paymentDateAccountA[index],
                            nameUser: arrayNameUsersAccountA[index],
                            paymentAmount: arrayPaymentAmountA[index],
                            idPago: arrayIdPayments[index],
                          );
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Usuarios de la cuenta",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: arrayidUserA.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinishedWorkoutView(
                                  idAccount: idAccount.toString(),
                                  userName: arraynameA[index].toString(),
                                  idUser: arrayidUserA[index].toString(),
                                  paymentDate: arraypaymentA[index].toString(),
                                  profileUser: arrayprofileA[index].toString(),
                                  amountUser: arrayamountA[index].toString(),
                                  phoneUser: arrayphoneA[index].toString(),
                                  pinUser: arraypinA[index].toString(),
                                  statusUser: arraystatusA[index].toString(),
                                  genreUser: arrayGenresA[index].toString(),
                                  account: accountName.toString(),
                                  pass: pass.toString(),
                                ),
                              ),
                            );
                          },
                          child: WorkoutRow(
                              idUser: arrayidUserA[index],
                              profileUser: arrayprofileA[index],
                              nameUser: arraynameA[index],
                              paymentUser: arraypaymentA[index],
                              amountUser: arrayamountA[index],
                              phoneUser: arrayphoneA[index],
                              pinUser: arraypinA[index],
                              statusUser: arraystatusA[index],
                              genreUser: arrayGenresA[index]));
                    }),
                SizedBox(
                  height: media.width * 0.1,
                ),
              ],
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
              style: TextStyle(fontSize: 18),
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
              print('obteniendo pagos...');
              obtenerPagosCuenta(idAccount, startDate, endDate);
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

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Sun', style: style);
        break;
      case 1:
        text = Text('Mon', style: style);
        break;
      case 2:
        text = Text('Tue', style: style);
        break;
      case 3:
        text = Text('Wed', style: style);
        break;
      case 4:
        text = Text('Thu', style: style);
        break;
      case 5:
        text = Text('Fri', style: style);
        break;
      case 6:
        text = Text('Sat', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 10.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 15, TColor.primaryG,
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 5.5, TColor.secondaryG,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 8.5, TColor.primaryG,
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartGroupData makeGroupData(
    int x,
    double y,
    List<Color> barColor, {
    bool isTouched = false,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          gradient: LinearGradient(
              colors: barColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.green)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: TColor.lightGray,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
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
}
