import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';


class TalkScreen extends StatefulWidget {
  @override
  _TalkScreenState createState() => _TalkScreenState();
}

class _TalkScreenState extends State<TalkScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;


  @override
  void initState() {
    super.initState();
    listenForPermissions();
    _speech = stt.SpeechToText();
  }

      void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.provisional:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        // endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        // repeatPauseDuration: const Duration(milliseconds: 100), 
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none)
        )
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text,
          )
        )
      )

    );
  }

  void _listen() async {
    if (!_isListening) {
      print('Not listening');
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'), 
        onError: (val) => print('onError: $val')
      );
      if (available) {
        print('Available');
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
      else {
        print('Not available');
      }
    }
    else {
      print('Listening');
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}