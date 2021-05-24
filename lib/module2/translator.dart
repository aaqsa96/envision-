import 'package:flutter/material.dart';
import 'package:object_detection/constant.dart';
import 'package:translator/translator.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreeneState createState() => _TranslatorScreeneState();
}

class _TranslatorScreeneState extends State<TranslatorScreen> {
  VoiceController controller = FlutterTextToSpeech.instance.voiceController();
  TextEditingController textEditingController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var output;
  String dropdownValue;

  static const Map<String, String> lang = {
    "Urdu": "ur",
    "English": "en",
    "Arabic": "ar",
    "Pashto": "ps",
    "Persian": "fa",
    "Japanese": "ja",
    "Hindi": "hi",
    "Latin": "la",
    "Turkish": "tr",
    "Gujarati": "gu",
    "Chinese Simplified": "zh-CN",
    "Bengali": "bn",
  };

  void trans() {
    translator
        .translate(textEditingController.text, to: "$dropdownValue")
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: TwoCardColor,
        title: Text("Multi Language Translator"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(8.0, 3, 3, 14),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: TextStyle(fontSize: 24),
                  controller: textEditingController,
                  onTap: () {
                    trans();
                  },
                  decoration: InputDecoration(
                      labelText: 'Type Here',
                      labelStyle: TextStyle(fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Select Language here =>"),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: TwoCardColor,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: TwoCardColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        trans();
                      });
                    },
                    items: lang
                        .map((string, value) {
                          return MapEntry(
                            string,
                            DropdownMenuItem<String>(
                              value: value,
                              child: Text(string),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.all(3),
                color: TwoCardColor,
                width: 250,
                height: 30,
                child: Text(
                  'Translated Text',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                output == null ? "Please Select Language" : output.toString(),
                style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TwoCardColor,
        child: Icon(Icons.volume_up),
        onPressed: () {
          controller.speak(output.toString());
        },
      ),
    );
  }
}
