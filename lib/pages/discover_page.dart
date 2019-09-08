import 'package:flutter/material.dart';
import '../database/rule.dart';
import 'rule_edit_page.dart';
import 'discover_show_page.dart';
import '../ui/show_error.dart';
import '../global/global.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Rule> rules;

  Future<bool> findAllRules() async {
    rules = await Global.ruleDao.findAllRules();
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: findAllRules(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ShowError(
              errorMsg: snapshot.error,
            );
          }
          if (!snapshot.hasData || !snapshot.data) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
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
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RuleEditPage())),
                        ),
                        IconButton(
                          icon: Icon(Icons.input),
                          onPressed: () async {
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
                      onPressed: () async {
                        await Global.ruleDao.deleteRuleById(rule.id);
                        setState(() {});
                      },
                    ),
                    title: Text(rule.name),
                    subtitle: Text(rule.host),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
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
          );
        },
      ),
    );
  }
}
