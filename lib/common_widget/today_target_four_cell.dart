import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';

class TodayTargetFourCell extends StatelessWidget {
  final String icon;
  final String value;
  final String title;
  const TodayTargetFourCell(
      {super.key,
      required this.icon,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                          colors: TColor.primaryG,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                },
                child: Text(
                  '$title',
                  style: TextStyle(
                      color: TColor.white.withOpacity(0.7),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: value.length > 20 ? 15 : 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
