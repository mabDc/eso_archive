import 'package:flutter/material.dart';
import '../utils/rule.dart';
import 'source_edit_page.dart';
import '../rule/example_video.dart';
import '../rule/thumbnail_example.dart';
import 'discover_show_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> rules = <Rule>[
      Rule.safeFromJson(ExampleVideo().rule),
      Rule.safeFromJson(ThumbnailExample().rule),
    ];
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
                      onPressed: () => print('add'),
                    ),
                    IconButton(
                      icon: Icon(Icons.input),
                      onPressed: () => print('input'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            Rule rule = rules[index];
            return Card(
              child: ListTile(
                title: Text(rule.name),
                subtitle: Text(rule.host),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RuleEditPage(rule))),
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
