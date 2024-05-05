import 'dart:io';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class Speech2Text {
  final SpeechToText _speech2Text = SpeechToText();

  String? _text;

  void init() async {}

  Speech2Text._privateConstructor() {
    init();
  }

  static final Speech2Text _instance = Speech2Text._privateConstructor();

  factory Speech2Text() {
    return _instance;
  }

  String? getLastListenedMessage() {
    return _text;
  }

  void clearLastMessage() {
    _text = null;
  }

  void listenMessage(widgetSetState, {func}) async {
    bool available = await _speech2Text.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'));

    if (!available) {
      throw "Error";
    }

    _speech2Text.listen(
      listenOptions:
          SpeechListenOptions(partialResults: false, cancelOnError: true),
      pauseFor: const Duration(seconds: 3),
      onResult: (result) => widgetSetState(
        () {
          _text = result.recognizedWords;
          func();
        },
      ),
    );
  }
}
