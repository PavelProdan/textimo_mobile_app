import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;
  String textButonNext = 'Am dezactivat Datele Mobile';
  String textButonBack = 'Inapoi';
  var showBackButton = false;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (context, _) {
        return Row(
          children: <Widget>[
            TextButton(
              onPressed: _.onStepContinue,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  textButonNext,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
            ),
            Visibility(
              visible: showBackButton,
              child: TextButton(
                onPressed: _.onStepCancel,
                child: const Text(
                  'Inapoi',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
            showBackButton = false;
            textButonNext = "Am dezactivat Datele Mobile";
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
            showBackButton = true;
            textButonNext = "Next";
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Pasul 1'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '1) Dezactiveaza Datele Mobile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}

class ConnectionGuide extends StatefulWidget {
  const ConnectionGuide({Key? key}) : super(key: key);

  @override
  State<ConnectionGuide> createState() => _ConnectionGuideState();
}

class _ConnectionGuideState extends State<ConnectionGuide> {
  @override
  Widget build(BuildContext context) {
    // return a scaffold that contains a Stepper widget
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ghid Conectare'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF3F63F1),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const StepperWidget(),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(child: Text("M-am conectat")),
            )
          ],
        ),
      ),
    );
  }
}
