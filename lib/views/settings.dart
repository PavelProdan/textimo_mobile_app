// this widget will manage the /save_livepage_settings POST route to save a new configuration
// for the live page style
// and /get_livepage_settings GET route to get the current configuration, without css_content
// to display in this widget for future edits
// after a change is made, /refresh_livepage GET route is called in order to reflect the changes

// this widget should contain a form with the following fields:
// - background color 1 @String "bg_gradient_color_one" -> example: "#33ccff"
// - background color 2 @String "bg_gradient_color_two" -> example: "#33ccff"
// - font_size @Int "font_size" -> example: 20
// - font_color @String "font_color" -> example: "#33ccff"
// - font_family @String "font_family" -> example: "Arial, Helvetica, sans-serif". This is the exact match for the CSS
// - text align @String "text_align" -> example: "center/left/middle".
// - show the title @String "showTitle" -> example: "yes"
// - show current verse number @String "showCurrentStrofaNumber" -> example: "yes"
// - padding left @Int "padding_left" -> example: 20 . This value affects the text when "left" is selected for text align
// - padding bottom @Int "padding_bottom" -> example: 20 . This value affects the space between title and verse

// These options will be implemented like this:
// the two background colors will be selected using a color picker

// the font size will be selected using a slider and/or a text field
// the font color will be selected using a color picker

// the font family will be selected using a dropdown menu
// the text align will be selected using a dropdown menu
// the left and bottom padding will be selected using a slider and/or a text field

// the show title and show current verse number will be selected using a checkbox

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color background_color_one = Colors.lightBlue;
  Color background_color_two = Colors.lightBlue;
  Color font_color = Colors.black;

  int text_font_size = 12;
  int text_left_padding = 12;
  int text_bottom_padding = 12;
  bool show_title = true;
  bool show_current_verse_number = true;

  final text_font_sizeController = TextEditingController();
  final text_left_paddingController = TextEditingController();
  final text_bottom_paddingController = TextEditingController();

  String current_font = "Arial, Helvetica, sans-serif";
  final fonts = [
    'Arial, Helvetica, sans-serif',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String current_align = "middle";
  final aligns = [
    'middle',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    super.initState();
    text_font_sizeController.text = text_font_size.toString();
    text_left_paddingController.text = text_left_padding.toString();
    text_bottom_paddingController.text = text_bottom_padding.toString();
  }

  @override
  void dispose() {
    text_font_sizeController.dispose();
    text_left_paddingController.dispose();
    text_bottom_paddingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF3F63F1),
          title: Text("Setări Textimo"),
        ),
        body: Visibility(
          visible: true,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
                child: Text("Culori de fundal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
                child: Text(
                    "Daca se aleg doua culori diferite se va aplica un efect de gradient intre cele doua.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 30, 0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alege o culoare'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: background_color_one,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    background_color_one = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Finalizează'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); //dismiss the color picker
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("Prima culoare de fundal"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: background_color_one,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 30, 7),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alege o culoare'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: background_color_two,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    background_color_two = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Finalizează'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); //dismiss the color picker
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("A doua culoare de fundal"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: background_color_two,
                  ),
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 187, 187, 187),
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 5, 5),
                child: Text("Textul afișat",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
                child: Text("Dimensiunea fontului (in px):",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
                child: SizedBox(
                  width: 70,
                  child: TextField(
                    controller: text_font_sizeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 30, 0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alege o culoare'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: font_color,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    font_color = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Finalizează'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); //dismiss the color picker
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: Text("Culoare text"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: font_color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 15, 0, 0),
                child: Text("Font text:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 30, 8),
                child: DropdownButton<String>(
                  value: current_font,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: const Color(0xFF3F63F1),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      current_font = newValue!;
                    });
                  },
                  items: fonts.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 187, 187, 187),
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 5, 5),
                child: Text("Opțiuni suplimentare de afișare",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 15, 0, 0),
                child: Text("Pozitie de afisare:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 0, 30, 8),
                child: DropdownButton<String>(
                  value: current_align,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: const Color(0xFF3F63F1),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      current_align = newValue!;
                    });
                  },
                  items: aligns.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
                child: Text("Padding stanga (in px):",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
                child: SizedBox(
                  width: 70,
                  child: TextField(
                    controller: text_left_paddingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
                child: Text("Padding jos (in px):",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(19, 5, 30, 0),
                child: SizedBox(
                  width: 70,
                  child: TextField(
                    controller: text_bottom_paddingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 10, 0),
                child: CheckboxListTile(
                  title: Text("Afișează titlul melodiei pe pagina Live"),
                  value: show_title,
                  onChanged: (bool? value) {
                    setState(() {
                      show_title = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 10, 0),
                child: CheckboxListTile(
                  title:
                      Text("Afișează numarul strofei curente pe pagina Live"),
                  value: show_current_verse_number,
                  onChanged: (bool? value) {
                    setState(() {
                      show_current_verse_number = value!;
                    });
                  },
                ),
              ),
              Divider(
                color: Color.fromARGB(255, 187, 187, 187),
                height: 20,
                thickness: 1,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Salvează setările"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F63F1),
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
