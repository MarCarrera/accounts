import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/workout_row.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../common/colo_extension.dart';
import 'activity_tracker_view.dart';
import 'finished_workout_view.dart';
import 'notification_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

   //VARIABLES QUE ALOJAN VALORES DE APIS--------------------------------
  List<String> arrayidAccount = [];
  List<String> arraynameAccount = [];
  List<String> arraypaymentAccount = [];
  List<String> arraypassword = [];
  List<String> arrayBanks = [];
  List<double> arrayTotalPay = [];
  //pagos de usuarios cuenta A-----------------------------------
  List<String> paymentDateAccountA = [];
  List<String> arrayNameUsersAccountA = [];
  List<String> arrayPaymentAmountA = [];
  double totalPaymentA = 0.0;
  bool showDataPaymentA = false;

  List<String> paymentDateAccountB = [];
  List<String> arrayNameUsersAccountB = [];
  List<String> arrayPaymentAmountB = [];
  double totalPaymentB = 0.0;

  List<String> paymentDateAccountC = [];
  List<String> arrayNameUsersAccountC = [];
  List<String> arrayPaymentAmountC = [];
  double totalPaymentC = 0.0;

  //PETICIONES A API---------------------------------------------
  Future<void> obtenerCuentas() async {
    var response = await getAccounts();
    if (response != "err_internet_conex") {
      print('Respuesta cuentas:::: $response');
      setState(() {
        //isLoading = false;
        if (response == 'empty') {
        } else {
          for (int i = 0; i < response.length; i++) {
            arrayidAccount.add(response[i]['idAccount'].toString());
            arraynameAccount.add(response[i]['nameAccount'].toString());
            arraypaymentAccount.add(response[i]['paymentDate'].toString());
            arraypassword.add(response[i]['password'].toString());
            arrayBanks.add(response[i]['bank'].toString());
          }
        }
      });
    } else {
      print('Sin conexion');
    }
  }
  //PETICIONES A API---------------------------------------------
  
  List accountArr = [
    {"image": "assets/img/p_personal.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/img/p_achi.png", "name": "Achievement", "tag": "2"},
    {
      "image": "assets/img/p_activity.png",
      "name": "Activity History",
      "tag": "3"
    },
    {
      "image": "assets/img/p_workout.png",
      "name": "Workout Progress",
      "tag": "4"
    }
  ];
  List lastWorkoutArr = [
    {
      "name": "Full Body Workout",
      "image": "assets/img/Workout1.png",
      "kcal": "180",
      "time": "20",
      "progress": 0.3
    },
    {
      "name": "Lower Body Workout",
      "image": "assets/img/Workout2.png",
      "kcal": "200",
      "time": "30",
      "progress": 0.4
    },
    {
      "name": "Ab Workout",
      "image": "assets/img/Workout3.png",
      "kcal": "300",
      "time": "40",
      "progress": 0.7
    },
  ];
  List<int> showingTooltipOnSpots = [21];

  List<FlSpot> get allSpots => const [
        FlSpot(0, 20),
        FlSpot(1, 25),
        FlSpot(2, 40),
        FlSpot(3, 50),
        FlSpot(4, 35),
        FlSpot(5, 40),
        FlSpot(6, 30),
        FlSpot(7, 20),
        FlSpot(8, 25),
        FlSpot(9, 40),
        FlSpot(10, 50),
        FlSpot(11, 35),
        FlSpot(12, 50),
        FlSpot(13, 60),
        FlSpot(14, 40),
        FlSpot(15, 50),
        FlSpot(16, 20),
        FlSpot(17, 25),
        FlSpot(18, 40),
        FlSpot(19, 50),
        FlSpot(20, 35),
        FlSpot(21, 80),
        FlSpot(22, 30),
        FlSpot(23, 20),
        FlSpot(24, 25),
        FlSpot(25, 40),
        FlSpot(26, 50),
        FlSpot(27, 35),
        FlSpot(28, 50),
        FlSpot(29, 60),
        FlSpot(30, 40)
      ];

  List waterArr = [
    {"title": "6am - 8am", "subtitle": "600ml"},
    {"title": "9am - 11am", "subtitle": "500ml"},
    {"title": "11am - 2pm", "subtitle": "1000ml"},
    {"title": "2pm - 4pm", "subtitle": "700ml"},
    {"title": "4pm - now", "subtitle": "900ml"},
  ];

  @override
  void initState() {
    super.initState();
    obtenerCuentas();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: false,
        barWidth: 3,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(colors: [
            TColor.primaryColor2.withOpacity(0.4),
            TColor.primaryColor1.withOpacity(0.1),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        dotData: FlDotData(show: false),
        gradient: LinearGradient(
          colors: TColor.primaryG,
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Scaffold(
      //backgroundColor: TColor.white,
      body: Container(
        decoration: BoxDecoration(
                      gradient: LinearGradient(colors: TColor.primaryG)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
                        "assets/img/bg_dots.png",
                        height: media.width * 0.4,
                        width: double.maxFinite,
                        fit: BoxFit.fitHeight,
                      ),
                      Container(
                        child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Accounts",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NotificationView(),
                                ),
                              );
                            },
                            icon: Image.asset(
                              "assets/img/notification_active.png",
                              width: 25,
                              height: 25,
                              fit: BoxFit.fitHeight,
                            ))
                      ],
                    ),
              
                    const SizedBox(
                    height: 25,
                  ),
                  //CARD CUENTAS------------------------------------------------------------------
                  const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: arrayidAccount.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(
                                height: 20,
                              ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: TColor.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black12, blurRadius: 2)
                                      ]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Account",
                                        style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: arrayidAccount.length,
                                        itemBuilder: (context, index) {
                                              return SettingRow(
                                                nameAccount: arraynameAccount[index],
                                                onPressed: () {print('seleccionado:::: ${arraynameAccount[index]}');}, 
                                                pass: arraypassword[index], paymentDate: arraypaymentAccount[index], banck: arrayBanks[index],
                                              );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                  
                  
                  //CARD CUENTAS------------------------------------------------------------------

                  //---------------PRUEBA------------
                  /*
                  
                    @override
                      Widget build(BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Tus cuentas'),
                          ),
                          body: ListView.builder(
                            itemCount: arrayidAccount.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(arraynameAccount[index]),
                                  subtitle: Text('ID: ${arrayidAccount[index]}'),
                                  // Puedes agregar más widgets ListTile según necesites
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } */

                  //--------------------------------
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColor.primaryColor2.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Today Target",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 70,
                            height: 25,
                            child: RoundButton(
                              title: "Check",
                              type: RoundButtonType.bgGradient,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ActivityTrackerView(),
                                  ),
                                );
                              },
                            ),
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
                        itemCount: lastWorkoutArr.length,
                        itemBuilder: (context, index) {
                          var wObj = lastWorkoutArr[index] as Map? ?? {};
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
                              child: WorkoutRow(wObj: wObj));
                        }),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
                      )
          ]
          
          
          
          
          
          
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
      (i) {
        var color0 = TColor.secondaryColor1;

        switch (i) {
          case 0:
            return PieChartSectionData(
                color: color0,
                value: 33,
                title: '',
                radius: 55,
                titlePositionPercentageOffset: 0.55,
                badgeWidget: const Text(
                  "20,1",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ));
          case 1:
            return PieChartSectionData(
              color: Colors.white,
              value: 75,
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.primaryColor2.withOpacity(0.5),
          TColor.primaryColor1.withOpacity(0.5),
        ]),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 35),
          FlSpot(2, 70),
          FlSpot(3, 40),
          FlSpot(4, 80),
          FlSpot(5, 25),
          FlSpot(6, 70),
          FlSpot(7, 35),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(colors: [
          TColor.secondaryColor2.withOpacity(0.5),
          TColor.secondaryColor1.withOpacity(0.5),
        ]),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
        ),
        spots: const [
          FlSpot(1, 80),
          FlSpot(2, 50),
          FlSpot(3, 90),
          FlSpot(4, 40),
          FlSpot(5, 80),
          FlSpot(6, 35),
          FlSpot(7, 60),
        ],
      );

  SideTitles get rightTitles => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: TextStyle(
          color: TColor.gray,
          fontSize: 12,
        ),
        textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: TColor.gray,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Sun', style: style);
        break;
      case 2:
        text = Text('Mon', style: style);
        break;
      case 3:
        text = Text('Tue', style: style);
        break;
      case 4:
        text = Text('Wed', style: style);
        break;
      case 5:
        text = Text('Thu', style: style);
        break;
      case 6:
        text = Text('Fri', style: style);
        break;
      case 7:
        text = Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
