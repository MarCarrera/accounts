
import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';

class TodayTargetTreeCell extends StatelessWidget {
  final String icon;
  final String icon2;
  final String value1;
  final String title1;
  final String value2;
  final String title2;
  const TodayTargetTreeCell({super.key, required this.icon, required this.value1, required this.title2, required this.title1, required this.value2, required this.icon2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: 
      
      Row(
        children: [
          Row(
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
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
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
                            child: Text('\$$value1',
                              style: TextStyle(
                                  color: TColor.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                          
                          Text(
                            title1,
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
          Row(
            children: [
              Image.asset(
               icon2,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
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
                            child: Text('\$$value2',
                              style: TextStyle(
                                  color: TColor.white.withOpacity(0.7),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                          ),
                          
                          Text(
                            title2,
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}