import 'package:flutter/material.dart';
import '../ui/color_list_tile.dart';
import '../global/global.dart';
import '../ui/option_switch.dart';

class ColorLensPage extends StatefulWidget {
  @override
  _ColorLensPageState createState() => _ColorLensPageState();
}

class _ColorLensPageState extends State<ColorLensPage> {
  bool _enEdit = false;
  TextEditingController r;
  TextEditingController g;
  TextEditingController b;

  @override
  void initState() {
    super.initState();
    Color _customColor = Color(Global().setting.customColorValue);
    r = TextEditingController(text: _customColor.red.toString());
    g = TextEditingController(text: _customColor.green.toString());
    b = TextEditingController(text: _customColor.blue.toString());
  }

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
              return Card(
                child: OptionSwitch(
                  title: Text('Night Mode'),
                  value: Global().setting.enBrightnessDark,
                  onChange: (value) async {
                    Global().setting.enBrightnessDark = value;
                    await Global().saveSetting();
                    Global().setTheme(() {});
                  },
                  onTap: () async {
                    Global().setting.enBrightnessDark =
                        !Global().setting.enBrightnessDark;
                    await Global().saveSetting();
                    Global().setTheme(() {});
                  },
                ),
              );
              break;
            case 1:
              Color _customColorValue = Color(Global().setting.customColorValue);
              return Card(
                child: ColorListTile(
                  title: _enEdit
                      ? Row(
                          children: <Widget>[
                            Container(
                              width: 80,
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                controller: r,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(helperText: 'red'),
                                maxLength: 3,
                                onChanged: (text) {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  setState(() {
                                    Global().setting.customColorValue =
                                        Color.fromARGB(
                                      0xff,
                                      _r > 0xff ? 0xff : _r,
                                      _g > 0xff ? 0xff : _g,
                                      _b > 0xff ? 0xff : _b,
                                    ).value;
                                  });
                                },
                                onSubmitted: (text) async {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  Global().setting.customColorValue =
                                      Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
                                  await Global().saveSetting();
                                  setState(() {
                                    _enEdit = false;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                controller: g,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(helperText: 'green'),
                                maxLength: 3,
                                onChanged: (text) {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  setState(() {
                                    Global().setting.customColorValue =
                                        Color.fromARGB(
                                      0xff,
                                      _r > 0xff ? 0xff : _r,
                                      _g > 0xff ? 0xff : _g,
                                      _b > 0xff ? 0xff : _b,
                                    ).value;
                                  });
                                },
                                onSubmitted: (text) async {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  Global().setting.customColorValue =
                                      Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
                                  await Global().saveSetting();
                                  setState(() {
                                    _enEdit = false;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: 80,
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                controller: b,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(helperText: 'blue'),
                                maxLength: 3,
                                onChanged: (text) {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  setState(() {
                                    Global().setting.customColorValue =
                                        Color.fromARGB(
                                      0xff,
                                      _r > 0xff ? 0xff : _r,
                                      _g > 0xff ? 0xff : _g,
                                      _b > 0xff ? 0xff : _b,
                                    ).value;
                                  });
                                },
                                onSubmitted: (text) async {
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  Global().setting.customColorValue =
                                      Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
                                  await Global().saveSetting();
                                  setState(() {
                                    _enEdit = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'custom color  r:${_customColorValue.red} g:${_customColorValue.green} b:${_customColorValue.blue}'),
                  subtitle: _enEdit
                      ? Container()
                      : Text('tap to active & long press to edit'),
                  color: _customColorValue,
                  onTap: () async {
                    Global().setting.colorValue =
                        Global().setting.customColorValue;
                    await Global().saveSetting();
                    Global().setTheme(() {});
                  },
                  onLongPress: () async {
                    setState(() {
                      _enEdit = true;
                    });
                  },
                ),
              );
              break;
            default:
              final primaryColor = Colors.primaries[index - 2];
              return Card(
                child: ColorListTile(
                  title: Text(
                      'r:${primaryColor.red} g:${primaryColor.green} b:${primaryColor.blue}'),
                  color: primaryColor,
                  onTap: () async {
                    Global().setting.colorValue = primaryColor.value;
                    await Global().saveSetting();
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
