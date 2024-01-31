import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class CardAccount extends StatelessWidget {
  final Icon icon;
  final List<String> accountArr;
  final String title;
  final VoidCallback onPressed;
  const CardAccount({super.key, required this.icon, required this.title, required this.onPressed, required this.accountArr });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          itemCount: accountArr.length,
                          itemBuilder: (context, index) {
                            var iObj = accountArr[index] as Map? ?? {};
                            return CardAccount(
                              icon: icon, //iObj["image"].toString(),
                              title: title, //iObj["name"].toString(),
                              onPressed: () {print('seleccionado:::: ${iObj["name"].toString()}');}, 
                              accountArr: [],
                            );
                          },
                        )
                      ],
                    ),
                  );
  }
}