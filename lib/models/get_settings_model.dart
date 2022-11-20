// To parse this JSON data, do
//
//     final getSettings = getSettingsFromJson(jsonString);

import 'dart:convert';

GetSettings getSettingsFromJson(String str) => GetSettings.fromJson(json.decode(str));

String getSettingsToJson(GetSettings data) => json.encode(data.toJson());

class GetSettings {
    GetSettings({
        required this.bgGradientColorOne,
        required this.bgGradientColorTwo,
        required this.fontSize,
        required this.fontColor,
        required this.fontFamily,
        required this.textAlign,
        required this.showTitle,
        required this.showCurrentStrofaNumber,
        required this.paddingLeft,
        required this.paddingBottom,
        required this.cssContent,
        required this.id,
    });

    String bgGradientColorOne;
    String bgGradientColorTwo;
    int fontSize;
    String fontColor;
    String fontFamily;
    String textAlign;
    String showTitle;
    String showCurrentStrofaNumber;
    int paddingLeft;
    int paddingBottom;
    String cssContent;
    String id;

    factory GetSettings.fromJson(Map<String, dynamic> json) => GetSettings(
        bgGradientColorOne: json["bg_gradient_color_one"],
        bgGradientColorTwo: json["bg_gradient_color_two"],
        fontSize: json["font-size"],
        fontColor: json["font-color"],
        fontFamily: json["font-family"],
        textAlign: json["text-align"],
        showTitle: json["showTitle"],
        showCurrentStrofaNumber: json["showCurrentStrofaNumber"],
        paddingLeft: json["padding-left"],
        paddingBottom: json["padding-bottom"],
        cssContent: json["css_content"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "bg_gradient_color_one": bgGradientColorOne,
        "bg_gradient_color_two": bgGradientColorTwo,
        "font-size": fontSize,
        "font-color": fontColor,
        "font-family": fontFamily,
        "text-align": textAlign,
        "showTitle": showTitle,
        "showCurrentStrofaNumber": showCurrentStrofaNumber,
        "padding-left": paddingLeft,
        "padding-bottom": paddingBottom,
        "css_content": cssContent,
        "_id": id,
    };
}
