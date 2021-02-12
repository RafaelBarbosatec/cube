import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'strings_location.dart';

/// Responsible for loading the current locate string file
class CubesLocalization {
  CubesLocalization(this.locale, {this.pathFiles = 'lang/'}) {
    CStringsLocation().cubesLocalisation = this;
  }

  final Locale locale;
  final String pathFiles;

  Map<String, String> _sentences;

  Future<bool> load() async {
    var data = await rootBundle.loadString('$pathFiles${locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    _sentences = {};
    _result.forEach((key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String trans(String key) {
    return _sentences[key] ?? '';
  }
}
