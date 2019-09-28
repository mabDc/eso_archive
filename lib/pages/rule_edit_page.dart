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
        title: Text('${rule.name}'),
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
            title: Text('基本信息' ,style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('id: ${rule.id}'),
                  subtitle: Text(
                      '创建时间 ${DateTime.fromMicrosecondsSinceEpoch(rule.id)}'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                  child: TextField(
                    controller: TextEditingController(text: rule.name),
                    minLines: 1,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: '名称(name)',
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
                      labelText: '域名(host)',
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
            title: Text('开关' ,style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  value: rule.enable,
                  title: Text('启用搜索(enable)'),
                  onChanged: (value) {
                    setState(() {
                      rule.enable = value;
                    });
                  },
                ),
                SwitchListTile(
                  value: rule.enCheerio,
                  title: Text('加载html解析库(enCheerio)'),
                  onChanged: (value) {
                    setState(() {
                      rule.enCheerio = value;
                    });
                  },
                ),
                SwitchListTile(
                  value: false,
                  title: Text('加载md5加密库(enMD5)'),
                  onChanged: null
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('发现规则 (discover)' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
                      labelText: '发现地址 (discoverUrl)',
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
                      labelText: '发现内容 (discoverItems)',
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
            title: Text('搜索规则 (search)' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
                      labelText: '搜索地址 (searchUrl)',
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
                      labelText: '搜索内容 (searchItems)',
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
            title: Text('详情页规则 (detail)' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
                      labelText: '详情页地址 (detailUrl)',
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
                      labelText: '详情页内容 (detailItems)',
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
            title: Text('章节规则 (chapter)' ,style: TextStyle(color: Theme.of(context).primaryColor),),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  value: rule.enMultiRoads,
                  title: Text('启用多线路 (enMultiRoads)'),
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
                      labelText: '章节地址 (chapterUrl)',
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
                      labelText: '章节内容 (chapterItems)',
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
            title: Text('正文规则 (content)' ,style: TextStyle(color: Theme.of(context).primaryColor),),
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
                      labelText: '正文地址 (contentUrl)',
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
                      labelText: '正文内容 (contentItems)',
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
