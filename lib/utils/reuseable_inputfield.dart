import 'package:flutter/material.dart';

class ReuseableInputFields extends StatefulWidget {
  String hintText, errorMsg, val;
  int len;
  bool isPass;
  bool isEmail;
  ReuseableInputFields(
      {super.key,
      required this.hintText,
      required this.errorMsg,
      required this.val,
      required this.isEmail,
      required this.len,
      required this.isPass});

  @override
  State<ReuseableInputFields> createState() => _ReuseableInputFieldsState();
}

class _ReuseableInputFieldsState extends State<ReuseableInputFields> {
  @override
  Widget build(BuildContext context) {
    bool hidePassword = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200]),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            suffixIcon: widget.isPass
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      // color: ColorConstant.deepOrange800,
                    ),
                  )
                : null,
          ),
          validator: widget.isEmail
              ? (val) {
                  const pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$";
                  final regex = RegExp(pattern);
                  if (!regex.hasMatch(val!)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                }
              : (val) {
                  if (val!.length < widget.len) {
                    return widget.errorMsg;
                  } else {
                    return null;
                  }
                },
          onChanged: (val) {
            setState(() {
              val = val;
            });
          },
        ),
      ),
    );
  }
}
