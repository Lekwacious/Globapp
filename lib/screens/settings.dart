import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globapp/models/font_size.dart';
import '../data/shared_pref.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673A87,
    0xFFF57C00,
    0xFF795548
  ];
  SPSettings? settings;
  final List<FontSize> fontSizes = [
    FontSize("small", 12),
    FontSize("medium", 16),
    FontSize("large", 20),
    FontSize("extra-large", 24),
  ];
  @override
  void initState() {
    settings?.init().then((value) {
      setState(() {
        settingColor = settings!.getColor();
        fontSize = settings!.getFontSize();
      });
    });
    super.initState();
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings?.setColor(color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Choose a font size for the app",
            style: TextStyle(fontSize: fontSize),
          ),
          DropdownButton(
            value: fontSize.toString(),
            items: getDropdownMenuItems(),
            onChanged: (String? newSize) {
              settings!.setFontSize(double.parse(newSize!));
              setState(() {
                fontSize = double.parse(newSize);
              });
            },
          ),
          Text('App Main Color'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[4]),
                child: ColorSquare(colors[4]),
              )
            ],
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (FontSize fontSize in fontSizes) {
      items.add(DropdownMenuItem(
        value: fontSize.size.toString(),
        child: Text(fontSize.name),
      ));
    }
    return items;
  }

  void changeSize(String newSize) {
    settings!.setFontSize(double.parse(newSize));
    setState(() {
      fontSize = double.parse(newSize);
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;

  ColorSquare(this.colorCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(colorCode),
      ),
    );
  }
}
