import 'package:flutter_tts/flutter_tts.dart';

class Text2Speech {
  final FlutterTts flutterTts = FlutterTts();

  void init() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.4);
  }

  Text2Speech._privateConstructor() {
    init();
  }

  static final Text2Speech _instance = Text2Speech._privateConstructor();

  factory Text2Speech() {
    return _instance;
  }

  void speak(String msg) async {
    await flutterTts.speak(msg);
  }

  void stop() async {
    await flutterTts.stop();
  }
}
