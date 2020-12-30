import 'package:flutter/material.dart';
import 'package:streakers_journal_beta/screens/welcome_screen.dart';

class MgavNavigationButton extends StatelessWidget {
  MgavNavigationButton({
    this.textNameOfRoute,
    //this.routeAsCode,
    this.buttonIcon,
    @required this.onPressedFunction,
  });

  final edgeInsets = 10.5;
  final sizedBoxButtonDividerWidth = 14.0;
  final buttonTextSize = 12.0;
  final buttonCornerRadius = 9.0;
  final gapBetweenButtonIconAndText = 4.0;
  IconData buttonIcon = Icons.youtube_searched_for;

  String textNameOfRoute = 'textNameOfRoute';
  //final routeAsCode = 'TasksScreen()';

  final Function onPressedFunction; // what happens when the button gets pressed

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonCornerRadius)),
      onPressed: onPressedFunction,
      color: Colors.white,
      padding: EdgeInsets.all(edgeInsets),
      child: Column(
        // Replace with a Row for horizontal icon + text
        children: <Widget>[
          Icon(
            buttonIcon,
            color: Colors.lightBlueAccent,
          ),
          SizedBox(
            height: gapBetweenButtonIconAndText,
          ),
          Text(
            textNameOfRoute,
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontSize: buttonTextSize,
            ),
          )
        ],
      ),
    );
  }
}
