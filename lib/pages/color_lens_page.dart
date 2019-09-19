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
                offset: value.toString().length,
              ),
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
