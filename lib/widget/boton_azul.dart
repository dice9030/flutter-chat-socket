import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String title;
  final Function onPress;

  const BotonAzul({Key key, @required this.title, @required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPress,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
