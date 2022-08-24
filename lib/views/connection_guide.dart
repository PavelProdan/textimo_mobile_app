import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
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
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Guide'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
        
      ),
      body: StepperWidget(),
    );
    
  }
}