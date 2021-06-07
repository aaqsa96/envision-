import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

import '../constant.dart';

class Details extends StatefulWidget {
  final String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  VoiceController controller = FlutterTextToSpeech.instance.voiceController();
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: TwoCardColor,
        title: Text('Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(widget.text)
                  .then((value) => _key.currentState
                      // ignore: deprecated_member_use
                      .showSnackBar(new SnackBar(content: Text('Copied'))));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? 'No Text Available' : widget.text),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TwoCardColor,
        child: Icon(Icons.volume_up),
        onPressed: () {
          controller.speak(widget.text);
        },
      ),
    );
  }
}
