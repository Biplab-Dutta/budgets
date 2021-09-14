import 'package:flutter/material.dart';

import 'package:budgets/constants.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: kAccentColor,
          elevation: 8,
          minimumSize: Size(200, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}