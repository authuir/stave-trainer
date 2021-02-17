import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/services.dart';
import 'package:stave_trainer_app/util.dart';

class StaveCanvasPainter extends CustomPainter {
  // The height of the first line of Stave
  static const double initHeight = 70;
  // Stave lines staveInterval
  static const double staveInterval = 14;
  static const double noteWidth = 18;
  static const double noteHeight = 14;
  static UI.Image symbolClefG;
  static UI.Image symbolClefF;

  Paint blackPaint = Paint();
  Paint greenPaint = Paint();
  Paint redPaint = Paint();
  SplayTreeMap<int, int> noteMap;
  SplayTreeMap<int, int> noteMapTest;
  bool isClefG = true;
  Map<int, double> notePositionMap = new Map();

  Future<UI.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  StaveCanvasPainter(SplayTreeMap<int, int> noteMap,
      SplayTreeMap<int, int> noteMapTest, bool isClefG) {
    var c4Height = initHeight + staveInterval * 4.5;
    this.noteMap = noteMap;
    this.noteMapTest = noteMapTest;

    blackPaint.color = Colors.black;
    blackPaint.strokeWidth = 2;
    greenPaint.color = Colors.green;
    greenPaint.strokeWidth = 2;
    redPaint.color = Colors.red;
    redPaint.strokeWidth = 2;
    this.isClefG = isClefG;
    this.notePositionMap = initNotePositionMap(
        this.notePositionMap, c4Height, staveInterval, isClefG);
    loadUiImage("img/ClefG.png")
        .then((s) => {StaveCanvasPainter.symbolClefG = s});
    loadUiImage("img/ClefF.png")
        .then((s) => {StaveCanvasPainter.symbolClefF = s});
  }

  @override
  void paint(Canvas canvas, Size size) {
    this.drawStave(canvas, size);
    this.drawNote(canvas, this.noteMap, true);
    this.drawNote(canvas, this.noteMapTest, false);
  }

  void drawStave(Canvas canvas, Size size) {
    // Draw Clef
    if (StaveCanvasPainter.symbolClefG != null) {
      canvas.drawImageRect(
          StaveCanvasPainter.symbolClefG,
          Rect.fromLTWH(0, 0, 1000, 2000),
          Rect.fromLTWH(10, initHeight - 10, 150, 300),
          blackPaint);
    }

    var staveLineHeight = initHeight;
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(Offset(0, staveLineHeight),
          Offset(size.width, staveLineHeight), blackPaint);
      staveLineHeight += staveInterval;
    }
  }

  void drawNote(
      Canvas canvas, SplayTreeMap<int, int> noteMap, bool isUserInput) {
    if (noteMap == null) {
      return;
    }

    double noteStartLeftMargin = 100;
    var lastNote;

    noteMap.forEach((k, v) {
      double noteLeftMargin = noteStartLeftMargin;
      if (lastNote != null && lastNote == (k - 1)) {
        noteLeftMargin += noteWidth;
      }

      if (isUserInput) {
        noteLeftMargin += 100;
      }

      // Draw additional lines for notes outside the stave
      if (isClefG && k < PianoNote.E4 && this.notePositionMap[k] != null) {
        var c4LineHeight =
            this.notePositionMap[PianoNote.C4] + staveInterval * 0.5;
        var positionHeight = this.notePositionMap[k] + staveInterval * 0.5;
        double number = -1;
        if (positionHeight >= c4LineHeight) {
          number = (positionHeight - c4LineHeight) / staveInterval + 0.5;
        }

        for (int i = 0; i < number; i++) {
          canvas.drawLine(
              Offset(noteLeftMargin - 5, c4LineHeight + i * staveInterval),
              Offset(noteLeftMargin + noteWidth + 5,
                  c4LineHeight + i * staveInterval),
              blackPaint);
        }
      }

      if (isClefG && k > PianoNote.F4 && this.notePositionMap[k] != null) {
        var a5LineHeight =
            this.notePositionMap[PianoNote.A5] + staveInterval * 0.5;
        var positionHeight = this.notePositionMap[k] + staveInterval * 0.5;
        double number = -1;
        if (positionHeight <= a5LineHeight) {
          number = (a5LineHeight - positionHeight) / staveInterval + 0.5;
        }

        for (int i = 0; i < number; i++) {
          canvas.drawLine(
              Offset(noteLeftMargin - 5, a5LineHeight - i * staveInterval),
              Offset(noteLeftMargin + noteWidth + 5,
                  a5LineHeight - i * staveInterval),
              blackPaint);
        }
      }

      var paint = this.blackPaint;

      if (isUserInput && this.noteMapTest[k] != null) {
        paint = this.greenPaint;
      } else if (isUserInput && this.noteMapTest[k] == null) {
        paint = this.redPaint;
      }

      if (this.notePositionMap[k] != null) {
        canvas.drawOval(
            Rect.fromLTWH(
                noteLeftMargin, this.notePositionMap[k], noteWidth, noteHeight),
            paint);
      }
      lastNote = k;
    });
  }

  @override
  bool shouldRepaint(StaveCanvasPainter other) {
    return true;
  }
}
