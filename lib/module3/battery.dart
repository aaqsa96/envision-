import 'dart:async';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:object_detection/constant.dart';

class BatteryPage extends StatefulWidget {
  @override
  _BatteryPageState createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  VoiceController controller =
      FlutterTextToSpeech.instance.voiceController(); //tts controller
  final battery = Battery();
  int batteryLevel = 100;
  BatteryState batteryState = BatteryState.full;

  Timer timer;
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    listenBatteryLevel();
    listenBatteryState();
    controller.init();
  }

  void listenBatteryState() =>
      subscription = battery.onBatteryStateChanged.listen(
        (batteryState) => setState(() => this.batteryState = batteryState),
      );

  void listenBatteryLevel() {
    updateBatteryLevel();

    timer = Timer.periodic(
      Duration(seconds: 10),
      (_) async => updateBatteryLevel(),
    );
  }

  Future updateBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;

    setState(() => this.batteryLevel = batteryLevel);
  }

  @override
  void dispose() {
    timer.cancel();
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kCardsColor,
        appBar: AppBar(
          backgroundColor: ThreeCardColor,
          automaticallyImplyLeading: false,
          title: Text('Battery checker'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBatteryState(batteryState),
              const SizedBox(height: 32),
              buildBatteryLevel(batteryLevel),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ThreeCardColor,
          onPressed: () {
            controller.speak('$batteryState and it is $batteryLevel%');
          },
          child: Icon(Icons.volume_up),
        ),
      );

  Widget buildBatteryState(BatteryState batteryState) {
    final style = TextStyle(fontSize: 32, color: Colors.white);
    final double size = 300;

    switch (batteryState) {
      case BatteryState.full:
        final color = Colors.green;

        return Column(
          children: [
            Icon(Icons.battery_full, size: size, color: color),
            Text('Full!', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.charging:
        final color = Colors.green;

        return Column(
          children: [
            Icon(Icons.battery_charging_full, size: size, color: color),
            Text('Charging...', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.discharging:
      default:
        final color = Colors.red;
        return Column(
          children: [
            Icon(Icons.battery_alert, size: size, color: color),
            Text('Discharging...', style: style.copyWith(color: color)),
          ],
        );
    }
  }

  Widget buildBatteryLevel(int batteryLevel) => Text(
        '$batteryLevel%',
        style: TextStyle(
          fontSize: 46,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
}
