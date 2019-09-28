import 'package:flutter/material.dart';
import '../database/rule.dart';
import 'rule_edit_page.dart';
import 'discover_show_page.dart';
import 'show_error.dart';
import '../global/global.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<Rule> rules;
  Rule lastDeleteRule;
  bool enEdit = false;

  Future<bool> findAllRules() async {
    rules = await Global.ruleDao.findAllRules();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                enEdit = !enEdit;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RuleEditPage())),
          ),
        ],
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
            itemCount: rules.length,
            itemBuilder: (context, index) {
              Rule rule = rules[index];
              return Card(
                child: enEdit
                    ? ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await Global.ruleDao.deleteRule(rule);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                '已删除',
                              ),
                              action: SnackBarAction(
                                label: '撤销',
                                textColor: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  await Global.ruleDao.insertOrUpdateRule(rule);
                                  setState(() {});
                                },
                              ),
                            ));
                            setState(() {});
                          },
                        ),
                        title: Text(rule.name),
                        subtitle: Text(rule.host),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RuleEditPage(rule: rule))),
                        ),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DiscoverShowPage(
                                      rule: rule,
                                    ))),
                      )
                    : ListTile(
                        title: Text(rule.name),
                        subtitle: Text(rule.host),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DiscoverShowPage(
                                      rule: rule,
                                    ))),
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
