import 'package:flutter/material.dart';

class ReuseableLocalDropDown extends StatefulWidget {
  String ? dropDownValue ;
  String ? val;
  List <String>items = [];
   ReuseableLocalDropDown({super.key, required this.dropDownValue, required this.val, required this.items});

  @override
  State<ReuseableLocalDropDown> createState() => _ReuseableLocalDropDownState();
}

class _ReuseableLocalDropDownState extends State<ReuseableLocalDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding:
        const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 5.0, left: 5.0),
        child: DropdownButton<String>(
          value: widget.dropDownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 15,
          elevation: 16,
          style: const TextStyle(color: Colors.black, fontSize: 12.0),
          underline: Container(
            height: 2,
            color: Colors.black12,
          ),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropDownValue = newValue!;
              widget.val = widget.dropDownValue;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
