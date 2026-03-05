// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Env {
  static const List<int> _enviedkeyencryptionKey = <int>[
    717604615,
    3367701686,
    1037120715,
    3053264378,
    850507176,
    314126428,
    643985541,
    3984747393,
    3635961382,
    4025116225,
    522709970,
    4263354279,
    950209410,
    3169870708,
    2883788320,
    891410220,
    1427956116,
  ];

  static const List<int> _envieddataencryptionKey = <int>[
    717604734,
    3367701721,
    1037120702,
    3053264264,
    850507255,
    314126397,
    643985653,
    3984747496,
    3635961465,
    4025116202,
    522709943,
    4263354334,
    950209501,
    3169870620,
    2883788357,
    891410270,
    1427956209,
  ];

  static final String encryptionKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataencryptionKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataencryptionKey[i] ^ _enviedkeyencryptionKey[i]),
  );
}
