import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:stave_trainer_app/staveCanvasPainter.dart';

class StavePage extends StatefulWidget {
  StavePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StavePageState createState() => _StavePageState();
}

class _StavePageState extends State<StavePage> {
  String text = 'Test';
  String btnConnectText = 'Connect Device';
  bool isConnected = false;
  Map<int, int> noteMap = new Map();
  MidiDevice device;
  Timer t;

  static const int CMD_UP = 128;
  static const int CMD_DOWN = 144;

  int debugC = 60;
  void handleTimeout(Timer t) {
    // callback function
    setState(() {
      this.noteMap[debugC++] = debugC;
      debugC++;
    });
    print(debugC);
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  void initDevice() async {
    String temp = '';
    this.t = new Timer.periodic(Duration(seconds: 3), handleTimeout);
    this.t.cancel();
    var devices = await MidiCommand().devices;
    devices.forEach((k) => temp += ' [' + k.name + '] ');
    temp += ' [' + devices.toString() + '] ';
    setState(() {
      this.text += temp;
    });
  }

  void _onMidiDataReceived(Uint8List data) {
    setState(() {
      this.text = data.toString() + 'length: ${data.length}';
    });
    if (data.length <= 0 || data.length % 3 != 0) {
      return;
    }
    for (int i = 0; i < data.length / 3; i++) {
      if (data[i] == CMD_DOWN) {
        setState(() {
          this.noteMap[data[i + 1]] = data[i + 2];
        });
      } else if (data[i] == CMD_UP) {
        setState(() {
          this.noteMap.remove(data[i + 1]);
        });
      }
    }
  }

  void _deviceBtn() {
    if (this.isConnected) {
      _disconnectDevice();
    } else {
      _connectDevice();
    }
  }

  void _connectDevice() async {
    var devices = await MidiCommand().devices;
    if (devices.length > 0) {
      this.device = devices[0];
      MidiCommand().connectToDevice(this.device);
      setState(() {
        this.text = 'Device ${device.name} Connected';
        this.isConnected = true;
        this.btnConnectText = '${device.name} Connected';
      });
      MidiCommand().onMidiDataReceived.listen(this._onMidiDataReceived);
    }
  }

  void _disconnectDevice() async {
    if (this.isConnected && this.device != null) {
      MidiCommand().disconnectDevice(this.device);
      setState(() {
        this.text = 'Device ${device.name} disconnected';
        this.isConnected = false;
        this.btnConnectText = 'Connect Device';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeRight,
    ]);
    initDevice();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ElevatedButton(
                  onPressed: _deviceBtn,
                  child: Text(this.btnConnectText),
                ),
              ),
              Container(
                child: Text(
                  this.text,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.red,
                      width: 5.0,
                    )),
                child: CustomPaint(
                  painter: StaveCanvasPainter(this.noteMap),
                  size: Size(660, 100),
                ),
              )
            ],
          ),
        ));
  }
}
