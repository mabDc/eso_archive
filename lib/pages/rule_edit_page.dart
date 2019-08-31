import 'dart:convert';

import 'package:eso/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/rule.dart';
import '../ui/option_switch.dart';
import '../ui/primary_color_text.dart';

class RuleEditPage extends StatefulWidget {
  RuleEditPage({
    this.rule,
    Key key,
  }) : super(key: key);

  final Rule rule;
  @override
  _RuleEditPageState createState() => _RuleEditPageState();
}

class _RuleEditPageState extends State<RuleEditPage> {
  Rule rule;

  // Widget _buildTextField(String text, String labelText) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
  //     child: TextField(
  //       controller: TextEditingController(text: text),
  //       minLines: 1,
  //       maxLines: null,
  //       decoration: InputDecoration(
  //         labelText: labelText,
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    rule = widget.rule ?? Rule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('edit-${rule.name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              Map<String, dynamic> map = Map<String, dynamic>();
              map.addAll({rule.id.toString(): rule.toJson()});
              Global().rule.addAll(map);
              await Global().saveRule();
            },
          ),
          IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: () async {
              await Clipboard.setData(
                  ClipboardData(text: jsonEncode(rule.toJson())));
            },
          ),
          IconButton(
            icon: Icon(Icons.content_paste),
            onPressed: () async {
              var ruleJson = await Clipboard.getData(Clipboard.kTextPlain);
              setState(() {
                rule = Rule.safeFromJson(jsonDecode(ruleJson.text));
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: PrimaryColorText('info'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('id: ${rule.id}'),
                  subtitle: Text(
                      'time ${DateTime.fromMicrosecondsSinceEpoch(rule.id)}'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.name),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'name',
                    ),
                    onChanged: (text) {
                      rule.name = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.host),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'host',
                    ),
                    onChanged: (text) {
                      rule.host = text;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      ['thumbnail', 'video'].map((type) {
                    return Flexible(
                      child: RadioListTile<String>(
                        value: type,
                        title: Text(type),
                        activeColor: Theme.of(context).primaryColor,
                        groupValue: rule.contentType,
                        onChanged: (value) {
                          rule.contentType = value;
                          setState(() {});
                        },
                      ),
                    );
                  }).toList(),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                //   child: TextField(
                //     controller: TextEditingController(text: rule.contentType),
                //     minLines: 1,
                //     maxLines: null,
                //     decoration: InputDecoration(
                //       labelText: 'contentType',
                //     ),
                //     onChanged: (text) {
                //       rule.contentType = text;
                //     },
                //   ),
                // ),

                //_buildTextField(, 'name'),
                //_buildTextField(rule.host, 'host'),
                //_buildTextField(rule.contentType, 'contentType'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('enable'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                OptionSwitch(
                  value: rule.enable,
                  title: Text('enable'),
                  onTap: () {
                    setState(() {
                      rule.enable = !rule.enable;
                    });
                  },
                  onChange: (value) {
                    setState(() {
                      rule.enable = value;
                    });
                  },
                ),
                OptionSwitch(
                  value: rule.enCheerio,
                  title: Text('enCheerio'),
                  onTap: () {
                    setState(() {
                      rule.enCheerio = !rule.enCheerio;
                    });
                  },
                  onChange: (value) {
                    setState(() {
                      rule.enCheerio = value;
                    });
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('discover'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.discoverUrl),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'discoverUrl',
                    ),
                    onChanged: (text) {
                      rule.discoverUrl = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.discoverItems),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'discoverItems',
                    ),
                    onChanged: (text) {
                      rule.discoverItems = text;
                    },
                  ),
                ),
                //_buildTextField(rule.discoverUrl, 'discoverUrl'),
                //_buildTextField(rule.discoverItems, 'discoverItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('search'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.searchUrl),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'searchUrl',
                    ),
                    onChanged: (text) {
                      rule.searchUrl = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.searchItems),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'searchItems',
                    ),
                    onChanged: (text) {
                      rule.searchItems = text;
                    },
                  ),
                ),
                //_buildTextField(rule.searchUrl, 'searchUrl'),
                //_buildTextField(rule.searchItems, 'searchItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('detail'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.detailUrl),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'detailUrl',
                    ),
                    onChanged: (text) {
                      rule.detailUrl = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.detailItems),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'detailItems',
                    ),
                    onChanged: (text) {
                      rule.detailItems = text;
                    },
                  ),
                ),
                //_buildTextField(rule.detailUrl, 'detailUrl'),
                //_buildTextField(rule.detailItems, 'detailItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('chapter'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                OptionSwitch(
                  value: rule.enMultiRoads,
                  title: Text('enMultiRoads'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.chapterUrl),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'chapterUrl',
                    ),
                    onChanged: (text) {
                      rule.chapterUrl = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.chapterItems),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'chapterItems',
                    ),
                    onChanged: (text) {
                      rule.chapterItems = text;
                    },
                  ),
                ),
                //_buildTextField(rule.chapterUrl, 'chapterUrl'),
                //_buildTextField(rule.chapterItems, 'chapterItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('content'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.contentUrl),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'contentUrl',
                    ),
                    onChanged: (text) {
                      rule.contentUrl = text;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.contentItems),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'contentItems',
                    ),
                    onChanged: (text) {
                      rule.contentItems = text;
                    },
                  ),
                ),
                //_buildTextField(rule.contentUrl, 'contentUrl'),
                //_buildTextField(rule.contentItems, 'contentItems'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
