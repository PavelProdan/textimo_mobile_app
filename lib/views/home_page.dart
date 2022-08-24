import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/components/drawer_menu.dart';
// ignore_for_file: prefer_const_constructors

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/textimoLogo.png',
            height: 40, fit: BoxFit.cover),
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search a song',
            onPressed: () => showDialogTest(context),

          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton.extended(
          elevation: 4.0,
          backgroundColor: Color(0xFFD9D9D9),
          label: Column(
            children: const [
              Text('Se vizualizeaza live:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400)),
              Text('The current song name',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w800)),
            ],
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: drawer_menu(),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Text("Example song number number $index"),
                  ),
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (String value) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Afiseaza',
                      child: Text('Afișează'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Previzualizeaza',
                      child: Text('Previzualizează'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Modifica',
                      child: Text('Modifică'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Sterge',
                      child: Text('Șterge'),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class MyStepperWidget extends StatefulWidget {
  const MyStepperWidget({Key? key}) : super(key: key);

  @override
  State<MyStepperWidget> createState() => _MyStepperWidgetState();
}

class _MyStepperWidgetState extends State<MyStepperWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        //Navigator.of(context).pop(false);
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

// create a method showDialogTest that will show a dialog box that contains MyStepperWidget
// wrap the stepper class in a Scaffold and SizedBox widget and add it to the body of the showDialogTest method

void showDialogTest(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: MyStepperWidget(),
        ),
      );
    },
  );
}