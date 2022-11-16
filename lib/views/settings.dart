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

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF3F63F1),
        title: Text("Setări"),

        actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.save),
                  tooltip: 'Salvează setările',
                  onPressed: () {
                    // save the settings and refresh the live page
                  }
                  ),
            ],
      ),

      body: Center(
        child: Text("Settings page"),
      ),
    );
  }
}