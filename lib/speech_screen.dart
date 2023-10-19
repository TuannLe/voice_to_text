import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_to_text/colors.dart';

class SpeechScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();

  var text = "Hold the button and start speaking";
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: const Duration(milliseconds: 1000),
          glowColor: primaryColor,
          repeat: true,
          repeatPauseDuration: const Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if(!isListening) {
                var available = await speechToText.initialize();
                if(available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(
                        onResult: (result) {
                          text = result.recognizedWords;
                        }
                    );
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
                speechToText.stop();
              });

            },
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 35.0,
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            )
        ),
      ),
      appBar: AppBar(
        leading: Icon(Icons.sort_rounded, color: Colors.white),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text(
          "Voice to text app",
          style: TextStyle(
            color: textColor,
            fontSize: 24.0,
            fontWeight: FontWeight.w500
          ),
        )
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          margin: const EdgeInsets.only(bottom: 150.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                color: isListening ? Colors.black87 : Colors.black54,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      )
    );
  }
}