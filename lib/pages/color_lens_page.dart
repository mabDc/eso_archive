import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/profile_change_notifier.dart';
import '../global/global.dart';

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
    final customColor = Color(Global.profile.customColor);
    r = TextEditingController(text: customColor.red.toString());
    g = TextEditingController(text: customColor.green.toString());
    b = TextEditingController(text: customColor.blue.toString());
  }

  void Function(String s) onChange(TextEditingController controller) {
    return (String s) {
      int number = int.tryParse(s);
      if (number == null || number < 0) {
        controller.text = "0";
      }
      if (number > 255) {
         controller.text = "255";
      }
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);
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
              Color _customColor = Color.fromARGB(0xff, int.parse(r.text),
                  int.parse(g.text), int.parse(b.text));
              return Card(
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _customColor,
                    ),
                    height: 32,
                    width: 32,
                  ),
                  title: _enEdit
                      ? Row(
                          children: <Widget>[
                            Container(
                              width: 60,
                              padding: EdgeInsets.only(right: 16),
                              child: TextField(
                                controller: r,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(helperText: 'red'),
                                onChanged: onChange(r),
                              ),
                            ),
                            Container(
                              width: 60,
                              padding: EdgeInsets.only(right: 16),
                              child: TextField(
                                controller: g,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(helperText: 'green'),
                                onChanged: onChange(g),
                              ),
                            ),
                            Container(
                              width: 60,
                              padding: EdgeInsets.only(right: 16),
                              child: TextField(
                                controller: b,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(helperText: 'blue'),
                                onChanged: onChange(b),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'custom color  r:${_customColor.red} g:${_customColor.green} b:${_customColor.blue}'),
                  trailing: IconButton(
                    icon: Icon(_enEdit ? Icons.save : Icons.mode_edit),
                    onPressed: () {
                      if (_enEdit) {
                        _enEdit = false;
                        setState(() {});
                        theme.customColor = _customColor.value;
                      } else {
                        _enEdit = true;
                        setState(() {});
                      }
                    },
                  ),
                  onTap: () async {
                    theme.color = theme.customColor;
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
