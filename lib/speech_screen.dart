import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen ({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController  = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> speak(String text) async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text To Speech'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Enter Text",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                speak(textController.text);
              },
              child: Text('Speak'),
            ),
          ],
        ),
      ),
    );
  }
}