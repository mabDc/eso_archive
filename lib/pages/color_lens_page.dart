import 'package:flutter/material.dart';
import '../ui/primary_color_text.dart';
import '../ui/color_list_tile.dart';
import '../global/global.dart';
import '../ui/option_switch.dart';

class ColorLensPage extends StatefulWidget {
  @override
  _ColorLensPageState createState() => _ColorLensPageState();
}

class _ColorLensPageState extends State<ColorLensPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Lens'),
      ),
      body: ListView.builder(
        itemCount: Colors.primaries.length + 2,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return ListTile(
                title: PrimaryColorText('theme pick'),
              );
              break;
            case 1:
              return Card(
                child: OptionSwitch(
                  title: Text('Night Mode'),
                  value: Global().option.enBrightnessDark,
                  onChange: (value) async {
                    Global().option.enBrightnessDark = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enBrightnessDark =
                        !Global().option.enBrightnessDark;
                    await Global().saveOption();
                    Global().setTheme(() {});
                  },
                ),
              );
              break;
            default:
              final primaryColor = Colors.primaries[index-2];
              return Card(
                child: ColorListTile(
                  title: Text(primaryColor.toString()),
                  color: primaryColor,
                  onTap: () async {
                    Global().option.materialColorIndex = index-2;
                    await Global().saveOption();
                    Global().setTheme(() {});
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
