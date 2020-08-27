import 'dart:async';
import 'dart:convert';

import 'package:cubes/src/localization/strings_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CubesLocalization {
  CubesLocalization(this.locale, {this.pathFiles = 'lang/'}) {
    StringsLocation.configure(this);
  }

  final Locale locale;
  final String pathFiles;

  Map<String, String> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('$pathFiles${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return this._sentences[key] ?? '';
  }
}