import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/today_target_cell.dart';
import 'package:fitness/common_widget/today_target_tree_cell.dart';
import 'package:fitness/common_widget/today_target_two_cell.dart';
import 'package:fitness/request/api_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';

class FinishedWorkoutView extends StatefulWidget {
  const FinishedWorkoutView({super.key, required this.userName, required this.idUser});
  final String userName;
  final String idUser;

  @override
  State<FinishedWorkoutView> createState() => _FinishedWorkoutViewState(userName, idUser);
}

class _FinishedWorkoutViewState extends State<FinishedWorkoutView> {

_FinishedWorkoutViewState(this.userName, this.idUser);
final String userName;
  final String idUser;

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
  List<String> paymentDateUserA = [];
  List<String> arrayPaymentStatusA = [];
  List<String> arrayPaymentAmountA = [];
  List<String> paymentDateUserB = [];
  List<String> arrayPaymentStatusB = [];
  List<String> arrayPaymentAmountB = [];
  List<String> paymentDateUserC = [];
  List<String> arrayPaymentStatusC = [];
  List<String> arrayPaymentAmountC = [];
  List<String> paymentDateUserD = [];
  List<String> arrayPaymentStatusD = [];
  List<String> arrayPaymentAmountD = [];
  List<String> paymentDateUserE = [];
  List<String> arrayPaymentStatusE = [];
  List<String> arrayPaymentAmountE = [];
  
    //pagos de usuario 1
  Future<void> obtenerPagosUsuario(String idUser) async {
    var response = await getPaymentsProfilesByUser(idUser);
    if (response != "err_internet_conex") {
       print('Respuesta pagos:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          paymentDateUserA.clear();
          arrayPaymentStatusA.clear();
          arrayPaymentAmountA.clear();

          if (paymentDateUserA.isEmpty &&
              arrayPaymentStatusA.isEmpty &&
              arrayPaymentAmountA.isEmpty) {
            for (int i = 0; i < response.length; i++) {
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
  @override
  void initState() {
    super.initState();
    obtenerPagosUsuario(idUser);
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                            value: '5 días',
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
                              profileUser: '',
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
