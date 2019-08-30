import 'package:flutter/material.dart';
import '../utils/rule.dart';
import '../ui/option_switch.dart';
import '../ui/primary_color_text.dart';

class RuleEditPage extends StatefulWidget {
  RuleEditPage(
    this.rule, {
    Key key,
  }) : super(key: key);

  final Rule rule;
  @override
  _RuleEditPageState createState() => _RuleEditPageState();
}

class _RuleEditPageState extends State<RuleEditPage> {
  Widget _buildTextField(String text, String labelText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14,0,14,8),
      child: TextField(
        controller: TextEditingController(text: text),
        minLines: 1,
        maxLines: null,

        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Rule rule = widget.rule;
    return Scaffold(
      appBar: AppBar(
        title: Text('edit-${rule.name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => print('save'),
          ),
          IconButton(
            icon: Icon(Icons.adb),
            onPressed: () => print('adb'),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => print('more_vert'),
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
                _buildTextField(rule.name, 'name'),
                _buildTextField(rule.host, 'host'),
                _buildTextField(rule.contentType, 'contentType'),
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
                ),
                OptionSwitch(
                  value: rule.enCheerio,
                  title: Text('enCheerio'),
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
                _buildTextField(rule.discoverUrl, 'discoverUrl'),
                _buildTextField(rule.discoverItems, 'discoverItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('search'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                _buildTextField(rule.searchUrl, 'searchUrl'),
                _buildTextField(rule.searchItems, 'searchItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('detail'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                _buildTextField(rule.detailUrl, 'detailUrl'),
                _buildTextField(rule.detailItems, 'detailItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('chapter'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                _buildTextField(rule.chapterUrl, 'chapterUrl'),
                 OptionSwitch(
                  value: rule.enMultiRoads,
                  title: Text('enMultiRoads'),
                ),
                _buildTextField(rule.chapterItems, 'chapterItems'),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('content'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                _buildTextField(rule.contentUrl, 'contentUrl'),
                _buildTextField(rule.contentItems, 'contentItems'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
