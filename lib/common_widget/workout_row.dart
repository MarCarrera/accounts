import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class WorkoutRow extends StatelessWidget {
  const WorkoutRow({super.key,});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    const String genre = 'f';
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(genre == 'f'
                    ? 'assets/icons/mujer.png'
                    : genre == 'm'
                        ? 'assets/icons/hombre.png'
                        : 'assets/icons/hombre2.png'),
              ),
              
              
               /*Image.asset(
                wObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),*/
            ),

           const SizedBox(width: 15,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text('perfil',
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 12),
                ),

                Text(
                  "nombre usuario",
                  style: TextStyle(
                      color: TColor.gray,
                      fontSize: 10,),
                ),

               const SizedBox(height: 4,),
              ],
            )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/img/next_icon.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
