import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/profile_change_notifier.dart';

class _ColorInput extends StatelessWidget {
  final int value;
  final String helperText;
  final void Function(int number) onChange;
  _ColorInput(this.value, this.helperText, this.onChange);

  int getNumber(String text) {
    int number = int.tryParse(text);
    if (number == null || number < 0) {
      number = 0;
    } else if (number > 255) {
      number = 255;
    } else if (text[0] == "0" && text.length == 2) {
      number = int.tryParse(text[1]);
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: EdgeInsets.only(right: 16),
      child: TextField(
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: value.toString(),
            selection: TextSelection.fromPosition(
              TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: value.toString().length),
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(helperText: helperText),
        onChanged: (text) {
          onChange(getNumber(text));
        },
      ),
    );
  }
}

class ColorLensPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (BuildContext context, ThemeModel themeModel, _) {
        final customColor = Color(themeModel.customColor);
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
                      value: themeModel.enDarkMode,
                      onChanged: (value) {
                        themeModel.enDarkMode = value;
                      },
                    ),
                  );
                  break;
                case 1:
                  return Card(
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: customColor),
                        height: 32,
                        width: 32,
                      ),
                      title: Row(
                        children: <Widget>[
                          _ColorInput(
                              customColor.red,
                              'red',
                              (red) => themeModel.customColor =
                                  customColor.withRed(red).value),
                          _ColorInput(
                              customColor.green,
                              'green',
                              (green) => themeModel.customColor =
                                  customColor.withGreen(green).value),
                          _ColorInput(
                              customColor.blue,
                              'blue',
                              (blue) => themeModel.customColor =
                                  customColor.withBlue(blue).value),
                        ],
                      ),
                      onTap: () {
                        themeModel.color = customColor.value;
                      },
                    ),
                  );
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
                      title: Text(
                          'r:${primaryColor.red} g:${primaryColor.green} b:${primaryColor.blue}'),
                      onTap: () {
                        themeModel.color = primaryColor.value;
                      },
                    ),
                  );
              }
            },
          ),
        );
      },
    );
  }
}
/*
class ColorLensPage extends StatefulWidget {
  @override
  _ColorLensPageState createState() => _ColorLensPageState();
}

class _ColorLensPageState extends State<ColorLensPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (BuildContext context, ThemeModel themeModel, _) {

        return Container();
      },
    );
  }
}



class ColorInputModel with ChangeNotifier {
  int _value;
  int get value => _value;

  ColorInputModel([int value = 0]) {
    _value = value;
  }

  void onChange(String text) {
    int number = int.tryParse(text);
    if (number == null || number < 0) {
      number = 0;
    } else if (number > 255) {
      number = 255;
    } else if (text[0] == "0" && text.length == 2) {
      number = int.tryParse(text[1]);
    }
    _value = number;
    notifyListeners();
  }
}


class ColorLensPage extends StatelessWidget {
  Widget _buildColorInput(String helperText, ColorInputModel colorInputModel) {
    return Container(
      width: 60,
      padding: EdgeInsets.only(right: 16),
      child: TextField(
        autofocus: true,
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: colorInputModel.value.toString(),
            selection: TextSelection.fromPosition(
              TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: colorInputModel.value.toString().length),
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(helperText: helperText),
        onChanged: (text) {
          colorInputModel.onChange(text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    // final primaryColor = Color(themeModel.color);
    final customColor = Color(themeModel.customColor);
    bool enEdit = true;
    return ChangeNotifierProvider.value(
      value: ColorInputModel(customColor.red),
      child: Consumer<ColorInputModel>(
        builder: (BuildContext context, ColorInputModel red, _) {
          return ChangeNotifierProvider.value(
            value: ColorInputModel(customColor.green),
            child: Consumer<ColorInputModel>(
              builder: (BuildContext context, ColorInputModel green, _) {
                return ChangeNotifierProvider.value(
                  value: ColorInputModel(customColor.blue),
                  child: Consumer<ColorInputModel>(
                    builder: (BuildContext context, ColorInputModel blue, _) {
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
                                    value: themeModel.enDarkMode,
                                    onChanged: (value) {
                                      themeModel.enDarkMode = value;
                                    },
                                  ),
                                );
                                break;
                              case 1:
                                Color customColor = Color.fromARGB(
                                    0xff, red.value, green.value, blue.value);
                                return Card(
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: customColor),
                                      height: 32,
                                      width: 32,
                                    ),
                                    title: enEdit
                                        ? Row(
                                            children: <Widget>[
                                              _buildColorInput('red', red),
                                              _buildColorInput('green', green),
                                              _buildColorInput('blue', blue),
                                            ],
                                          )
                                        : Text(
                                            'r:${customColor.red} g:${customColor.green} b:${customColor.blue}'),
                                    onTap: () {
                                      themeModel.color = customColor.value;
                                    },
                                    trailing: IconButton(
                                      icon: Icon(enEdit
                                          ? Icons.save
                                          : Icons.mode_edit),
                                      onPressed: () {
                                        if (enEdit) {
                                          themeModel.customColor =
                                              customColor.value;
                                        }
                                        enEdit = !enEdit;
                                      },
                                    ),
                                  ),
                                );
                              default:
                                final primaryColor =
                                    Colors.primaries[index - 2];
                                return Card(
                                  child: ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor),
                                      height: 32,
                                      width: 32,
                                    ),
                                    //color: primaryColor,
                                    title: Text(
                                        'r:${primaryColor.red} g:${primaryColor.green} b:${primaryColor.blue}'),
                                    onTap: () {
                                      themeModel.color = primaryColor.value;
                                    },
                                  ),
                                );
                            }
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );

    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(
          builder: (_) => ColorInputModel(customColor.red),
        ),
        ChangeNotifierProvider.value(
          value: ColorInputModel(customColor.green),
        ),
        ChangeNotifierProvider.value(
          value: ColorInputModel(customColor.blue),
        ),
        Provider<bool>.value(value: true),
      ],
      child: Consumer3<ColorInputModel, ColorInputModel, ColorInputModel>(
        builder: (BuildContext context, ColorInputModel red,
            ColorInputModel green, ColorInputModel blue, _) {
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
                        value: themeModel.enDarkMode,
                        onChanged: (value) {
                          themeModel.enDarkMode = value;
                        },
                      ),
                    );
                    break;
                  case 1:
                    Color customColor = Color.fromARGB(
                        0xff, red.value, green.value, blue.value);
                    return Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: customColor),
                          height: 32,
                          width: 32,
                        ),
                        title: enEdit
                            ? Row(
                                children: <Widget>[
                                  _buildColorInput('red', red),
                                  _buildColorInput('green', green),
                                  _buildColorInput('blue', blue),
                                ],
                              )
                            : Text(
                                'r:${customColor.red} g:${customColor.green} b:${customColor.blue}'),
                        onTap: () {
                          themeModel.color = customColor.value;
                        },
                        trailing: IconButton(
                          icon: Icon(enEdit ? Icons.save : Icons.mode_edit),
                          onPressed: () {
                            if (enEdit) {
                              themeModel.customColor = customColor.value;
                            }
                            enEdit = !enEdit;
                          },
                        ),
                      ),
                    );
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
                        onTap: () {
                          themeModel.color = primaryColor.value;
                        },
                      ),
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}


class ColorLensPage extends StatefulWidget {
  @override
  _ColorLensPageState createState() => _ColorLensPageState();
}

class _ColorLensPageState extends State<ColorLensPage> {
  bool _enEdit = false;
  int red;
  int green;
  int blue;

  @override
  void initState() {
    super.initState();
    final customColor = Color(Global.profile.customColor);
    red = customColor.red;
    green = customColor.green;
    blue = customColor.blue;
  }

  Widget _buildNumberInput(
      int value, String helperText, void Function(int value) changeValue,
      {bool autofocus = false}) {
    return Container(
      width: 60,
      padding: EdgeInsets.only(right: 16),
      child: TextField(
        autofocus: autofocus,
        controller: TextEditingController.fromValue(TextEditingValue(
            text: value.toString(),
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: value.toString().length)))),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(helperText: helperText),
        onChanged: (value) {
          int number = int.tryParse(value);
          if (number == null || number < 0) {
            number = 0;
          } else if (number > 255) {
            number = 255;
          } else if (value[0] == "0" && value.length == 2) {
            number = int.tryParse(value[1]) ?? 0;
          }
          setState(() {
            changeValue(number);
          });
        },
      ),
    );
  }

  void Function(String s) onChange(TextEditingController controller) {
    return (String s) {
      int number = int.tryParse(s);
      if (number == null || number < 0) {
        var inputText = "0";
        controller = TextEditingController.fromValue(TextEditingValue(
            text: inputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream, offset: inputText.length))));
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
              Color _customColor = Color.fromARGB(0xff, red, green, blue);
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
                            _buildNumberInput(
                                red, 'red', (value) => red = value,
                                autofocus: true),
                            _buildNumberInput(
                                green, 'green', (value) => green = value),
                            _buildNumberInput(
                                blue, 'blue', (value) => blue = value),
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
*/
