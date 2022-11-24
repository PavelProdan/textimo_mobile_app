import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textimo_mobile_app/main.dart';
import 'package:textimo_mobile_app/views/check_connection.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;
  String textButonNext = 'Am dezactivat Datele Mobile';
  String textButonBack = 'Înapoi';
  var showBackButton = false;
  var showNextButton = true;
  var showsubmitButton = false;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (context, _) {
        return Row(
          children: <Widget>[
            Visibility(
              visible: showNextButton,
              child: TextButton(
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
            ),
            Visibility(
              visible: showBackButton,
              child: TextButton(
                onPressed: _.onStepCancel,
                child: const Text(
                  'Înapoi',
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
            showNextButton = true;
            textButonNext = "Am dezactivat Datele Mobile";
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
            showBackButton = false;
            showNextButton = false;
          });
        }
      },
      steps: <Step>[
        Step(
          title: const Text('Pasul 1'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '1) Dezactivează Datele Mobile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
        ),
        Step(
          title: const Text('Pasul 2'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: ListView(scrollDirection: Axis.vertical, shrinkWrap: true,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Text(
                      '2) Conectează-te la rețeaua WiFi "textimo"',
                      style:
                          // ignore: prefer_const_constructors
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Rețeaua WiFi "textimo" nu apare? Verifică dacă dispozitivul RaspberryPi este pornit de cel puțin 1 minut.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.offAll(CheckConnectionWidget());
                      },
                      // ignore: sort_child_properties_last
                      // ignore: prefer_const_constructors
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        // ignore: prefer_const_constructors
                        child: Text(
                          "M-am conectat",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                      ),
                    ),
                  ])),
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
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Se pare că nu esti conectat la dispozitivul Textimo. Te rugăm să urmezi pasii de mai jos pentru a te conecta.',
                style:
                    // ignore: prefer_const_constructors
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const StepperWidget(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Atentie! Este posibil să primesti un mesaj de tipul "Acest WiFi nu are acces la internet". Este important să pastrezi conexiunea cu WiFi-ul Textimo pentru a putea folosi aplicatia.',
                style:
                    // ignore: prefer_const_constructors
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
