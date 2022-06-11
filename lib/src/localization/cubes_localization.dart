import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'strings_location.dart';

Map<String, String> _jsonCache = {};

/// Responsible for loading the current locate string file
@Deprecated(
  'Please use default flutter internationalization (https://docs.flutter.dev/development/accessibility-and-localization/internationalization)',
)
class CubesLocalization {
  /// Primary constructor of the  CubesLocalization
  CubesLocalization(this.locale, {this.pathFiles = 'lang/'}) {
    CStringsLocation().cubesLocalisation = this;
  }

  /// Locate of the language
  final Locale locale;

  /// path where the json files are located
  final String pathFiles;

  final Map<String, String> _sentences = {};

  /// Load json according to locale
  Future<bool> load() async {
    final fileName = '$pathFiles${locale.languageCode}.json';
    String data = '';
    if (!_jsonCache.containsKey(fileName)) {
      data = await rootBundle.loadString(fileName);
      _jsonCache[fileName] = data;
    }
    Map<String, dynamic> _result = json.decode(_jsonCache[fileName]!);
    _sentences.clear();
    _result.forEach((key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  /// Get String by key
  String trans(String key) {
    return _sentences[key] ?? '';
  }
}
