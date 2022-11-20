import 'dart:convert';
import 'package:textimo_mobile_app/config/config.dart' as config;
import 'package:http/http.dart' as http;

class SaveSettings {
  Future<http.Response> saveSettings(
    String bg_gradient_color_one,
    String bg_gradient_color_two,
    int font_size,
    String font_color,
    String font_family,
    String text_align,
    String show_title,
    String show_current_strofa_number,
    int padding_left,
    int padding_bottom,
  ) async {
  return http.post(
    Uri.parse('${config.textimo_ip}/save_livepage_settings'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "bg_gradient_color_one": bg_gradient_color_one,
      "bg_gradient_color_two": bg_gradient_color_two,
      "font_size": font_size,
      "font_color": font_color,
      "font_family": font_family,
      "text_align": text_align,
      "show_title": show_title,
      "show_current_strofa_number": show_current_strofa_number,
      "padding_left": padding_left,
      "padding_bottom": padding_bottom,
    }),
  );
}
}