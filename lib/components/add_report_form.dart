import 'package:flutter/material.dart';
import 'package:textimo_mobile_app/services/add_new_report_service.dart';


class add_report_form extends StatefulWidget {
  final String songId;
  final String verseNumber;

  const add_report_form({super.key, required this.songId, required this.verseNumber});

  @override
  add_report_formState createState() {
    return add_report_formState();
  }
}

//get the songId from the parameter and save it in a variable


// Create a corresponding State class.
// This class holds data related to the form.
class add_report_formState extends State<add_report_form> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: myController,
            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Problema indentificată..',
                ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Acest câmp este obligatoriu';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  
                  // insert the data into the database
                  var response = await AddNewReportService().addNewReport(widget.songId, widget.verseNumber, myController.text);
                  if(response.statusCode == 200){
                    Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Problema a fost adaugată cu succes.')),
                  );
                  }else{
                    Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text('Eroare! Problema nu a putut fi adaugată: $response')),
                  );
                  }
                  
                }
              },
              child: const Text('Trimite'),
            ),
          ),
        ],
      ),
    );
  }
}