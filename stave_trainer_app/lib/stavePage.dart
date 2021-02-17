import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:stave_trainer_app/staveCanvasPainter.dart';
import 'package:stave_trainer_app/util.dart';

class StavePage extends StatefulWidget {
  StavePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StavePageState createState() => _StavePageState();
}

class _StavePageState extends State<StavePage> {
  String text = 'Test';
  int score = 0;
  int life = 5;
  String btnConnectText = 'Connect Device';
  bool isConnected = false;
  bool isStartTrain = false;
  SplayTreeMap<int, int> noteMap = new SplayTreeMap();
  SplayTreeMap<int, int> noteMapTest = new SplayTreeMap();
  MidiDevice device;
  Timer t;
  Timer timer;

  static const int CMD_UP = 128;
  static const int CMD_DOWN = 144;

  void handleTimeout(Timer t) {
    // if (this.isStartTrain) {
    //   setRandomTest();
    // }
  }

  void setRandomTest() {
    this.noteMapTest.clear();
    var rng = new Random();
    var randomKey =
        Util.noteMapTestLib[rng.nextInt(Util.noteMapTestLib.length)];
    setState(() {
      this.noteMapTest[randomKey] = 100;
    });
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  void initDevice() async {
    String temp = '';
    this.t = new Timer.periodic(Duration(seconds: 1), handleTimeout);
    var devices = await MidiCommand().devices;
    devices.forEach((k) => temp += ' [' + k.name + '] ');
    temp += ' [' + devices.toString() + '] ';
    setState(() {
      this.text += temp;
    });
  }

  void _onMidiDataReceived(Uint8List data) {
    // setState(() {
    //   this.text = data.toString() + 'length: ${data.length}';
    // });
    if (data.length <= 0 || data.length % 3 != 0) {
      return;
    }
    for (int i = 0; i < data.length / 3; i++) {
      if (data[i] == CMD_DOWN) {
        setState(() {
          this.noteMap[data[i + 1]] = data[i + 2];
        });

        if (this.noteMapTest[data[i + 1]] != null) {
          setState(() {
            this.score++;
          });
        } else {
          this.life--;
          if (this.life <= 0) {
            this._stopTrain();
          }
        }
      } else if (data[i] == CMD_UP) {
        setState(() {
          this.noteMap.remove(data[i + 1]);
        });
        if (this.isStartTrain) {
          this.timer = new Timer(Duration(seconds: 1), setRandomTest);
        }
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

  void _trainBtn() {
    if (this.isStartTrain) {
      _stopTrain();
    } else {
      _startTrain();
    }
  }

  void _startTrain() async {
    if (!this.isStartTrain) {
      setState(() {
        this.isStartTrain = true;
        this.score = 0;
        this.life = 5;
      });
    }
    this.setRandomTest();
  }

  void _stopTrain() async {
    if (this.isStartTrain) {
      setState(() {
        this.isStartTrain = false;
        this.text = 'Game Over, final score: ${this.score.toString()}';
      });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 14),
                  ElevatedButton(
                      onPressed: _deviceBtn, child: Text(this.btnConnectText)),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: _trainBtn,
                      child: Text(
                          this.isStartTrain ? 'Stop Train' : 'Start Train'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              this.isStartTrain ? Colors.pink : Colors.green))),
                  SizedBox(width: 10),
                  Text(
                    'Score: ${this.score.toString()}',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
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
                  painter:
                      StaveCanvasPainter(this.noteMap, this.noteMapTest, true),
                  size: Size(660, 200),
                ),
              )
            ],
          ),
        ));
  }
}
