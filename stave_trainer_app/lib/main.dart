import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stave_trainer_app/stavePage.dart';

void main() {
  runApp(StaveTrainerApp());
}

String title = 'Authuir Stave Trainer';

class StaveTrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _onPopPage() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  void _navigate() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StavePage(title: title)),
    );
    _onPopPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _navigate,
                child: Text('Start Trainer'),
              )
            ],
          ),
        ));
  }
}
