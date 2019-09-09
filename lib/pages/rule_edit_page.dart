import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database/rule.dart';
import '../global/global.dart';

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

  @override
  void initState() {
    rule = widget.rule ?? Rule.newRule();
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
              await Global.ruleDao.insertOrUpdateRule(rule);
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
            title: Text('info' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
                
              ],
            ),
          ),
          ListTile(
            title: Text('enable' ,style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  value: rule.enable,
                  title: Text('enable'),
                  onChanged: (value) {
                    setState(() {
                      rule.enable = value;
                    });
                  },
                ),
                SwitchListTile(
                  value: rule.enCheerio,
                  title: Text('enCheerio'),
                  onChanged: (value) {
                    setState(() {
                      rule.enCheerio = value;
                    });
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('discover' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
            title: Text('search' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
            title: Text('detail' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
            title: Text('chapter' ,style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  value: rule.enMultiRoads,
                  title: Text('enMultiRoads'),
                  onChanged: (value){
                    setState(() {
                     rule.enMultiRoads = value; 
                    });
                  },
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
            title: Text('content' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
