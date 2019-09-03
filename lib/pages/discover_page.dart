import 'package:flutter/material.dart';
import '../utils/rule.dart';
import 'rule_edit_page.dart';
import 'discover_show_page.dart';
import '../rule/thumbnail_example.dart';
import '../rule/video_example.dart';
class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    // List<dynamic> rules = <Rule>[
    //   Rule.safeFromJson(ExampleVideo().rule),
    //   Rule.safeFromJson(ThumbnailExample().rule),
    // ];
    List<dynamic> rules = <dynamic>[
        Rule.safeFromJson(VideoExample().rule),
        Rule.safeFromJson(ThumbnailExample().rule)
    ];
    // Global().rule.forEach((id, ruleJson) {
    //   rules.add(Rule.safeFromJson(ruleJson));
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('discover'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () => print('search'),
        //   ),
        // ],
      ),
      body: ListView.builder(
        itemCount: rules.length + 1,
        itemBuilder: (context, index) {
          if (index == rules.length) {
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed:  () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RuleEditPage())),
                    ),
                    IconButton(
                      icon: Icon(Icons.input),
                      onPressed: () async{
                        // await Clipboard.setData(
                        //   ClipboardData(text: jsonEncode(Global().rule)));
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            Rule rule = rules[index];
            return Card(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async{
                    // Global().rule.remove(rule.id.toString());
                    // await Global().saveRule();
                    // setState(() {
                      
                    // });
                  },
                ),
                title: Text(rule.name),
                subtitle: Text(rule.host),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RuleEditPage(rule: rule))),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DiscoverShowPage(
                          rule: rule,
                        ))),
              ),
            );
          }
        },
      ),
    );
  }
}
