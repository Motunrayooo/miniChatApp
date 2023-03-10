import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({
    this.buttonColor, this.buttonTitle, @required this.buttonOnpressed
  }) ;

 final Color buttonColor;
 final String buttonTitle;
 final Function buttonOnpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: buttonOnpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
