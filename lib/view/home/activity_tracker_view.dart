import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/workout_row.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/home/finished_workout_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/latest_activity_row.dart';
import '../../common_widget/today_target_cell.dart';

class ActivityTrackerView extends StatefulWidget {
  const ActivityTrackerView({super.key, required this.idAccount});

  final String idAccount;

  @override
  State<ActivityTrackerView> createState() => _ActivityTrackerViewState(idAccount);
}

class _ActivityTrackerViewState extends State<ActivityTrackerView> {
  //CONSTRUCTOR DE CLASE PARA HACER USO DE LAS VARIABLES COMPARTIDAS
  _ActivityTrackerViewState(this.idAccount);
  final String idAccount;

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
  String date1 = '2024-01-01';

  String date2 = '2024-01-31';
  
  // String date1 = DateFormat('yyyy-MM-dd')
  //     .format(DateTime(DateTime.now().year, DateTime.now().month, 1));

  // String date2 = DateFormat('yyyy-MM-dd').format(DateTime.now());
   //pagos de usuarios cuenta A-----------------------------------
  List<String> paymentDateAccountA = [];
  List<String> arrayNameUsersAccountA = [];
  List<String> arrayPaymentAmountA = [];
  double totalPaymentA = 0.0;
  bool showDataPaymentA = false;
  List<double> arrayTotalPay = [];
  //OBTENER PAGOS DE CUENTA-------------------------------
  Future<void> obtenerPagosCuenta(String date1, String date2) async {
    var response = await getPaymentsProfilesByAccountDate('1', date1, date2);
    if (response != "err_internet_conex") {
      print('Respuesta pagos cuenta :::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          paymentDateAccountA.clear();
          arrayNameUsersAccountA.clear();
          arrayPaymentAmountA.clear();
          totalPaymentA = 0.0;
          // arrayTotalPay.clear();

          if (paymentDateAccountA.isEmpty &&
              arrayNameUsersAccountA.isEmpty &&
              arrayPaymentAmountA.isEmpty) {
            for (int i = 0; i < response.length; i++) {
              paymentDateAccountA.add(response[i]['paymentDate'].toString());
              arrayNameUsersAccountA.add(response[i]['nameUser'].toString());
              arrayPaymentAmountA.add(response[i]['amountPay'].toString());
              double? amountPayA = double.tryParse(response[i]['amountPay']);
              totalPaymentA += amountPayA ?? 0.0;
            }
            arrayTotalPay.add(totalPaymentA);
            print("total pago a::::: $totalPaymentA ");
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }
  //------------------------------------------------------
  @override
  void initState() {
    super.initState();
    obtenerPagosCuenta(date1, date2);
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
          "Activity Tracker",
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            children: [
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
                          "idAccount: $idAccount",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
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
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                height: 30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                textColor: TColor.primaryColor1,
                                minWidth: double.maxFinite,
                                elevation: 0,
                                color: Colors.transparent,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                )),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/img/water.png",
                            value: "8L",
                            title: "Water Intake",
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TodayTargetCell(
                            icon: "assets/img/foot.png",
                            value: "2400",
                            title: "Foot Steps",
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
                          }, paymentDate: paymentDateAccountA[index], 
                          nameUser: arrayNameUsersAccountA[index], 
                          paymentAmount: arrayPaymentAmountA[index],
                         
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
                            "Latest Workout",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See More",
                              style: TextStyle(
                                  color: TColor.gray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FinishedWorkoutView(),
                                    ),
                                  );
                                },
                                child: WorkoutRow());
                          }),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
            ],
          ),
        ),
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
        text =  Text('Sun', style: style);
        break;
      case 1:
        text =  Text('Mon', style: style);
        break;
      case 2:
        text =  Text('Tue', style: style);
        break;
      case 3:
        text =  Text('Wed', style: style);
        break;
      case 4:
        text =  Text('Thu', style: style);
        break;
      case 5:
        text =  Text('Fri', style: style);
        break;
      case 6:
        text =  Text('Sat', style: style);
        break;
      default:
        text =  Text('', style: style);
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
            return makeGroupData(0, 5, TColor.primaryG , isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 10.5, TColor.secondaryG, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, TColor.primaryG , isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, TColor.secondaryG, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 15, TColor.primaryG , isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 5.5, TColor.secondaryG, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 8.5, TColor.primaryG , isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

    BarChartGroupData makeGroupData(
    int x,
    double y,
    List<Color> barColor,
     {
    bool isTouched = false,
    
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          gradient: LinearGradient(colors: barColor, begin: Alignment.topCenter, end: Alignment.bottomCenter ),
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

}
