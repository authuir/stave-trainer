import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/services.dart';

class StaveCanvas {
  static const int C4 = 60;
  static const int C4R = 61;
  static const int D4 = 62;
  static const int D4R = 63;
  static const int E4 = 64;
  static const int F4 = 65;
  static const int F4R = 66;
  static const int G4 = 67;
  static const int G4R = 68;
  static const int A4 = 69;
  static const int A4R = 70;
  static const int B4 = 71;
  static const int B4R = 72;

  static const int C5 = 73;
  static const int C5R = 74;
  static const int D5 = 75;
  static const int D5R = 76;
  static const int E5 = 77;
  static const int F5 = 78;
  static const int F5R = 79;
  static const int G5 = 80;
  static const int G5R = 81;
  static const int A5 = 82;
  static const int A5R = 83;
  static const int B5 = 84;
  static const int B5R = 85;
  static UI.Image symbol;
}

class StaveCanvasPainter extends CustomPainter {
  static const double height = 14;
  static const double noteWidth = 18;
  static const double noteHeight = 14;
  Map<int, int> noteMap;
  Map<int, double> notePositionMap = new Map();

  Future<UI.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  StaveCanvasPainter(Map<int, int> noteMap) {
    this.noteMap = noteMap;
    var noteArray = [
      StaveCanvas.C4,
      StaveCanvas.D4,
      StaveCanvas.E4,
      StaveCanvas.F4,
      StaveCanvas.G4,
      StaveCanvas.A4,
      StaveCanvas.B4,
      StaveCanvas.C5,
      StaveCanvas.D5,
      StaveCanvas.E5,
      StaveCanvas.F5,
      StaveCanvas.G5,
      StaveCanvas.A5,
      StaveCanvas.B5,
    ];
    var xg = 6.5;
    for (final note in noteArray) {
      xg -= 0.5;
      notePositionMap[note] = height * xg;
    }

    loadUiImage("img/btn.png").then((s) => {StaveCanvas.symbol = s});
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    double initHeight = 20;

    if (StaveCanvas.symbol != null) {
      canvas.drawImageRect(StaveCanvas.symbol, Rect.fromLTWH(0, 0, 1000, 2000),
          Rect.fromLTWH(10, 10, 150, 300), paint);
    }

    for (int i = 0; i < 5; i++) {
      canvas.drawLine(
          Offset(0, initHeight), Offset(size.width, initHeight), paint);
      initHeight += height;
    }

    if (this.noteMap == null) {
      return;
    }

    this.noteMap.forEach((k, v) => {
          if (this.notePositionMap[k] != null)
            {
              canvas.drawOval(
                  Rect.fromLTWH(
                      100, this.notePositionMap[k], noteWidth, noteHeight),
                  paint)
            }
        });
  }

  @override
  bool shouldRepaint(StaveCanvasPainter other) {
    return true;
  }
}
