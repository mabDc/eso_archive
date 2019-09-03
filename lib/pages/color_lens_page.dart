import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/profile_change_notifier.dart';

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
    
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
    Color _customColor = Color(theme.color);
    r = TextEditingController(text: _customColor.red.toString());
    g = TextEditingController(text: _customColor.green.toString());
    b = TextEditingController(text: _customColor.blue.toString());
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
                child: SwitchListTile(
                  title: Text('Night Mode'),
                  value: theme.enDarkMode,
                  onChanged: (value) async {
                    theme.enDarkMode = value;
                  },
                ),
              );
              break;
            case 1:
              Color _customColorValue = Color(theme.customColor);
              return Card(
                child: ListTile(
                  // color: _customColorValue,
                  leading: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: _customColorValue),
                    height: 32,
                    width: 32,
                  ),
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
                                    theme.customColor = Color.fromARGB(
                                      0xff,
                                      _r > 0xff ? 0xff : _r,
                                      _g > 0xff ? 0xff : _g,
                                      _b > 0xff ? 0xff : _b,
                                    ).value;
                                  });
                                },
                                onSubmitted: (text) {
                                  _enEdit = false;
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  theme.customColor = Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
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
                                  theme.customColor = Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
                                },
                                onSubmitted: (text) {
                                  _enEdit = false;
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  theme.customColor = Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
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
                                  theme.customColor = Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
                                },
                                onSubmitted: (text) async {
                                  _enEdit = false;
                                  int _r = int.parse(r.text);
                                  int _g = int.parse(g.text);
                                  int _b = int.parse(b.text);
                                  theme.customColor = Color.fromARGB(
                                    0xff,
                                    _r > 0xff ? 0xff : _r,
                                    _g > 0xff ? 0xff : _g,
                                    _b > 0xff ? 0xff : _b,
                                  ).value;
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
                  onTap: () async {
                    theme.color = theme.customColor;
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
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    height: 32,
                    width: 32,
                  ),
                  //color: primaryColor,
                  title: Text(
                      'r:${primaryColor.red} g:${primaryColor.green} b:${primaryColor.blue}'),
                  onTap: () async {
                    theme.color = primaryColor.value;
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
