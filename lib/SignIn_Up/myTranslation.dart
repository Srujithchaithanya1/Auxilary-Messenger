import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();

class myTranslation {

  Future<String> translate_sent(String sentence, String lang) async {
    var translation =
        await translator.translate(sentence, from: 'en', to: lang);
    return translation.text.toString();
  }
}
