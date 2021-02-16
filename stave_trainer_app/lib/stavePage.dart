import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StavePage extends StatefulWidget {
  StavePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StavePageState createState() => _StavePageState();
}

class _StavePageState extends State<StavePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Text(
          widget.title,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
