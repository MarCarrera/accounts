import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/setting_row.dart';
import 'package:fitness/common_widget/workout_row.dart';
import 'package:fitness/request/api_request.dart';
import 'package:fitness/view/utils/buttonOptions.dart';
import 'package:fitness/view/utils/show_editing_account.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  final TextEditingController passController = TextEditingController();

  //VARIABLES QUE ALOJAN VALORES DE APIS--------------------------------
  List<String> arrayidAccount = [];
  List<String> arraynameAccount = [];
  List<String> arraypaymentAccount = [];
  List<String> arraypassword = [];
  List<String> arrayBanks = [];

  //PETICIONES A API---------------------------------------------
  Future<void> obtenerCuentas() async {
    var response = await getAccounts();
    if (response != "err_internet_conex") {
      //print('Respuesta cuentas:::: $response');
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
    double responsiveHeight = MediaQuery.of(context).size.height;
    double responsiveWidth = MediaQuery.of(context).size.width;

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
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
        child: Stack(alignment: Alignment.center, children: [
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
                                print('Navegando::::');
                                /*Navigator.push(
                                  context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const ButtonOptions(),
                                    ),
                                  ); */
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
                        height: 32,
                      ),
                      //CARD CUENTAS------------------------------------------------------------------
                      CardAccount(responsiveHeight),

                      //CARD CUENTAS------------------------------------------------------------------

                      SizedBox(
                        height: media.width * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Container PaymentsAccount(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: TColor.primaryColor2.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pagos de cuenta",
            style: TextStyle(
                color: TColor.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 70,
            height: 25,
            child: RoundButton(
              title: "Ver",
              type: RoundButtonType.bgGradient,
              fontSize: 16.5,
              fontWeight: FontWeight.w400,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityTrackerView(
                      idAccount: arrayidAccount[index].toString(),
                      accountName: arraynameAccount[index],
                      pass: arraypassword[index],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  ListView CardAccount(double responsiveHeight) {
    var media = MediaQuery.of(context).size;
    return ListView.builder(
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 2)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameAccount(index),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        PaymentAccount(index),
                        const SizedBox(
                          height: 8,
                        ),
                        PassAccount(index),
                        const SizedBox(
                          height: 8,
                        ),
                        BankAccount(index),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Divider(
                    height: 3,
                    color: Colors.black,
                  ),
                  OptionsAccount(context, responsiveHeight, index)
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            PaymentsAccount(context, index),
          ],
        );
      },
    );
  }

  Column OptionsAccount(
      BuildContext context, double responsiveHeight, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                print('Compartir datos...');
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 38,
                    width: 26,
                    child: Icon(
                      Icons.share_outlined,
                      color: TColor.black,
                      size: 22,
                    ),
                  ),
                  Text(
                    'Compartir datos',
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                print('Editar contraseña...');
                ShowEditingAccount().showEditAccount(
                  context,
                  responsiveHeight,
                  arrayidAccount[index],
                  arraypassword[index],
                  passController,
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 38,
                    width: 26,
                    child: Icon(
                      Icons.edit,
                      color: TColor.black,
                      size: 22,
                    ),
                  ),
                  Text(
                    'Cambiar contraseña',
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row BankAccount(int index) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Banco: ${arrayBanks[index]}',
            style: TextStyle(
              color: TColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 38,
          width: 26,
          child: Icon(
            Icons.remove_red_eye,
            color: TColor.black,
            size: 22,
          ),
        ),
        const SizedBox(
          width: 22,
        ),
        SizedBox(
          height: 38,
          width: 26,
          child: Icon(
            Icons.copy,
            color: TColor.black,
            size: 22,
          ),
        ),
      ],
    );
  }

  Row PassAccount(int index) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Contraseña: ${arraypassword[index]}',
            style: TextStyle(
              color: TColor.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 38,
          width: 26,
          child: Icon(
            Icons.remove_red_eye,
            color: TColor.black,
            size: 22,
          ),
        ),
        const SizedBox(
          width: 22,
        ),
        SizedBox(
          height: 38,
          width: 26,
          child: Icon(
            Icons.copy,
            color: TColor.black,
            size: 22,
          ),
        ),
      ],
    );
  }

  Text PaymentAccount(int index) {
    return Text(
      'Mensualidad: ${arraypaymentAccount[index]}',
      style: TextStyle(
        color: TColor.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text NameAccount(int index) {
    return Text(
      'Cuenta: ${arraynameAccount[index]}',
      style: TextStyle(
        color: TColor.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
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
