// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputSavingsTextFields extends StatelessWidget {
  InputSavingsTextFields({
    super.key,
    required this.myController,
    required this.hintText,
    required this.labelText,
    required this.editable,
  });
  TextEditingController myController;
  String hintText;
  String labelText;
  bool editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding:
        const EdgeInsets.only(top: 3.0, bottom: 10.0, right: 10.0, left: 10.0),
        child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: myController,
            style:const  TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle:  const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                // labelText: labelText,
                enabled: editable,
                labelStyle:
                const TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
