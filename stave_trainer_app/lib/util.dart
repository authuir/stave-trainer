Map<int, double> initNotePositionMap(Map<int, double> notePositionMap,
    double c4Height, double staveLineHeight, bool isClefG) {
  var noteArray = [
    PianoNote.C4,
    PianoNote.D4,
    PianoNote.E4,
    PianoNote.F4,
    PianoNote.G4,
    PianoNote.A4,
    PianoNote.B4,
    PianoNote.C5,
    PianoNote.D5,
    PianoNote.E5,
    PianoNote.F5,
    PianoNote.G5,
    PianoNote.A5,
    PianoNote.B5,
    PianoNote.C6,
    PianoNote.D6,
    PianoNote.E6,
    PianoNote.F6,
    PianoNote.G6,
    PianoNote.A6,
    PianoNote.B6,
    PianoNote.C7,
    PianoNote.D7,
    PianoNote.E7,
    PianoNote.F7,
    PianoNote.G7,
    PianoNote.A7,
    PianoNote.B7,
    PianoNote.C8,
    PianoNote.D8,
    PianoNote.E8,
    PianoNote.F8,
    PianoNote.G8,
    PianoNote.A8,
    PianoNote.B8,
  ];

  if (isClefG) {
    for (int i = 0; i < noteArray.length; i++) {
      notePositionMap[noteArray[i]] = c4Height - i * 0.5 * staveLineHeight;
    }
  }

  noteArray = [
    PianoNote.A0,
    PianoNote.B0,
    PianoNote.C1,
    PianoNote.D1,
    PianoNote.E1,
    PianoNote.F1,
    PianoNote.G1,
    PianoNote.A1,
    PianoNote.B1,
    PianoNote.C2,
    PianoNote.D2,
    PianoNote.E2,
    PianoNote.F2,
    PianoNote.G2,
    PianoNote.A2,
    PianoNote.B2,
    PianoNote.C3,
    PianoNote.D3,
    PianoNote.E3,
    PianoNote.F3,
    PianoNote.G3,
    PianoNote.A3,
    PianoNote.B3,
  ];

  if (isClefG) {
    for (int i = 0; i < noteArray.length; i++) {
      notePositionMap[noteArray[noteArray.length - i - 1]] =
          c4Height + (i + 1) * 0.5 * staveLineHeight;
    }
  }

  notePositionMap[PianoNote.A0R] = notePositionMap[PianoNote.A0];

  notePositionMap[PianoNote.C1R] = notePositionMap[PianoNote.C1];
  notePositionMap[PianoNote.D1R] = notePositionMap[PianoNote.D1];
  notePositionMap[PianoNote.F1R] = notePositionMap[PianoNote.F1];
  notePositionMap[PianoNote.G1R] = notePositionMap[PianoNote.G1];
  notePositionMap[PianoNote.A1R] = notePositionMap[PianoNote.A1];

  notePositionMap[PianoNote.C2R] = notePositionMap[PianoNote.C2];
  notePositionMap[PianoNote.D2R] = notePositionMap[PianoNote.D2];
  notePositionMap[PianoNote.F2R] = notePositionMap[PianoNote.F2];
  notePositionMap[PianoNote.G2R] = notePositionMap[PianoNote.G2];
  notePositionMap[PianoNote.A2R] = notePositionMap[PianoNote.A2];

  notePositionMap[PianoNote.C3R] = notePositionMap[PianoNote.C3];
  notePositionMap[PianoNote.D3R] = notePositionMap[PianoNote.D3];
  notePositionMap[PianoNote.F3R] = notePositionMap[PianoNote.F3];
  notePositionMap[PianoNote.G3R] = notePositionMap[PianoNote.G3];
  notePositionMap[PianoNote.A3R] = notePositionMap[PianoNote.A4];

  notePositionMap[PianoNote.C4R] = notePositionMap[PianoNote.C4];
  notePositionMap[PianoNote.D4R] = notePositionMap[PianoNote.D4];
  notePositionMap[PianoNote.F4R] = notePositionMap[PianoNote.F4];
  notePositionMap[PianoNote.G4R] = notePositionMap[PianoNote.G4];
  notePositionMap[PianoNote.A4R] = notePositionMap[PianoNote.A4];

  notePositionMap[PianoNote.C5R] = notePositionMap[PianoNote.C5];
  notePositionMap[PianoNote.D5R] = notePositionMap[PianoNote.D5];
  notePositionMap[PianoNote.F5R] = notePositionMap[PianoNote.F5];
  notePositionMap[PianoNote.G5R] = notePositionMap[PianoNote.G5];
  notePositionMap[PianoNote.A5R] = notePositionMap[PianoNote.A5];

  notePositionMap[PianoNote.C6R] = notePositionMap[PianoNote.C6];
  notePositionMap[PianoNote.D6R] = notePositionMap[PianoNote.D6];
  notePositionMap[PianoNote.F6R] = notePositionMap[PianoNote.F6];
  notePositionMap[PianoNote.G6R] = notePositionMap[PianoNote.G6];
  notePositionMap[PianoNote.A6R] = notePositionMap[PianoNote.A6];

  notePositionMap[PianoNote.C7R] = notePositionMap[PianoNote.C7];
  notePositionMap[PianoNote.D7R] = notePositionMap[PianoNote.D7];
  notePositionMap[PianoNote.F7R] = notePositionMap[PianoNote.F7];
  notePositionMap[PianoNote.G7R] = notePositionMap[PianoNote.G7];
  notePositionMap[PianoNote.A7R] = notePositionMap[PianoNote.A7];

  notePositionMap[PianoNote.C8R] = notePositionMap[PianoNote.C8];
  notePositionMap[PianoNote.D8R] = notePositionMap[PianoNote.D8];
  notePositionMap[PianoNote.F8R] = notePositionMap[PianoNote.F8];
  notePositionMap[PianoNote.G8R] = notePositionMap[PianoNote.G8];
  notePositionMap[PianoNote.A8R] = notePositionMap[PianoNote.A8];

  return notePositionMap;
}

class Util {
  static List<int> noteMapTestLib = [
    PianoNote.A3,
    PianoNote.B3,
    PianoNote.C4,
    PianoNote.D4,
    PianoNote.E4,
    PianoNote.F4,
    PianoNote.G4,
    PianoNote.A4,
    PianoNote.B4,
    PianoNote.C5,
    PianoNote.D5,
    PianoNote.E5,
    PianoNote.F5,
    PianoNote.G5,
    PianoNote.A5,
    PianoNote.B5,
    PianoNote.C6,
    PianoNote.D6,
    PianoNote.E6,
    PianoNote.F6,
    PianoNote.G6,
  ];
}

class PianoNote {
  static const int A0 = 21;
  static const int A0R = 22;
  static const int B0 = 23;

  static const int C1 = 24;
  static const int C1R = 25;
  static const int D1 = 26;
  static const int D1R = 27;
  static const int E1 = 28;
  static const int F1 = 29;
  static const int F1R = 30;
  static const int G1 = 31;
  static const int G1R = 32;
  static const int A1 = 33;
  static const int A1R = 34;
  static const int B1 = 35;

  static const int C2 = 36;
  static const int C2R = 37;
  static const int D2 = 38;
  static const int D2R = 39;
  static const int E2 = 40;
  static const int F2 = 41;
  static const int F2R = 42;
  static const int G2 = 43;
  static const int G2R = 44;
  static const int A2 = 45;
  static const int A2R = 46;
  static const int B2 = 47;

  static const int C3 = 48;
  static const int C3R = 49;
  static const int D3 = 50;
  static const int D3R = 51;
  static const int E3 = 52;
  static const int F3 = 53;
  static const int F3R = 54;
  static const int G3 = 55;
  static const int G3R = 56;
  static const int A3 = 57;
  static const int A3R = 58;
  static const int B3 = 59;

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

  static const int C5 = 72;
  static const int C5R = 73;
  static const int D5 = 74;
  static const int D5R = 75;
  static const int E5 = 76;
  static const int F5 = 77;
  static const int F5R = 78;
  static const int G5 = 79;
  static const int G5R = 80;
  static const int A5 = 81;
  static const int A5R = 82;
  static const int B5 = 83;

  static const int C6 = 84;
  static const int C6R = 85;
  static const int D6 = 86;
  static const int D6R = 87;
  static const int E6 = 88;
  static const int F6 = 89;
  static const int F6R = 90;
  static const int G6 = 91;
  static const int G6R = 92;
  static const int A6 = 93;
  static const int A6R = 94;
  static const int B6 = 95;

  static const int C7 = 96;
  static const int C7R = 97;
  static const int D7 = 98;
  static const int D7R = 99;
  static const int E7 = 100;
  static const int F7 = 101;
  static const int F7R = 102;
  static const int G7 = 103;
  static const int G7R = 104;
  static const int A7 = 105;
  static const int A7R = 106;
  static const int B7 = 107;

  static const int C8 = 108;
  static const int C8R = 109;
  static const int D8 = 110;
  static const int D8R = 111;
  static const int E8 = 112;
  static const int F8 = 113;
  static const int F8R = 114;
  static const int G8 = 115;
  static const int G8R = 116;
  static const int A8 = 117;
  static const int A8R = 118;
  static const int B8 = 119;
}
