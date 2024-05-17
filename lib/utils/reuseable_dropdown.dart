import 'package:flutter/material.dart';

class ReuseableDropDown extends StatefulWidget {
  String? mySelection;
  List? data = [];
  String itemName;
  String hintText;
   ReuseableDropDown({super.key, required this.mySelection, required this.data, required this.itemName, required this.hintText});

  @override
  State<ReuseableDropDown> createState() => _ReuseableDropDownState();
}

class _ReuseableDropDownState extends State<ReuseableDropDown> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint:  Text(widget.hintText),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              value: widget.mySelection,
              onChanged: (String? newVal) {
                setState(() {
                  widget.mySelection = newVal!;
                });
              },
              items: widget.data!.isNotEmpty
                  ? widget.data?.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item[widget.itemName].toString(),
                  child: Text(item[widget.itemName]),
                );
              }).toList()
                  : [
                const DropdownMenuItem<String>(
                  value: 'Loading',
                  child: Text('Please wait...'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

