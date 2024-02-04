import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      required this.controller,
      required this.text,
      required this.icon});

  final TextEditingController controller;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    double responsiveWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: responsiveWidth * 0.4,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return value!.isNotEmpty ? null : "Nombre vacío";
        },
        decoration: InputDecoration(
            hintText: text,
            //fillColor: Colors.deepPurple.shade100,
            filled: true,
            enabled: true,
            prefixIcon: Icon(icon),
            prefixIconColor: TColor.primaryColor1,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}

class DateForm extends StatelessWidget {
  const DateForm(
      {super.key,
      required this.controller,
      required this.text,
      required this.icon});

  final TextEditingController controller;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    double responsiveWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: responsiveWidth * 0.4,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return value!.isNotEmpty ? null : "Nombre vacío";
        },
        decoration: InputDecoration(
            hintText: text,
            //fillColor: Colors.deepPurple.shade100,
            filled: true,
            enabled: false,
            prefixIcon: Icon(icon),
            prefixIconColor: TColor.primaryColor2,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
