import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import '../database/search_item.dart';
import 'video_page.dart';
import 'thumbnail_detail_page.dart';
import '../database/rule.dart';
import '../global/global.dart';
import '../ui/show_error.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    this.searchItem,
    Key key,
  }) : super(key: key);

  final SearchItem searchItem;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<bool> initFuture;
  JSContext jsContext;
  Rule rule;

  Future<bool> init() async {
    rule = await Global.ruleDao.findRuleById(widget.searchItem.ruleID);
    if (rule == null) {
      return false;
    }
    if (rule.enCheerio) {
      String script =
          await DefaultAssetBundle.of(context).loadString(Global.cheerioFile);
      await jsContext.evaluateScript(script);
    }
    await jsContext.setProperty('host', rule.host);
    await jsContext.setProperty('item', widget.searchItem.item);
    return true;
  }

  @override
  void initState() {
    super.initState();
    initFuture = init();
    jsContext = JSContext();
  }

  @override
  void dispose() {
    if (jsContext != null) {
      jsContext.cleanUp();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ShowError(
            errorMsg: snapshot.error,
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.data) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                'rule not find',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          );
        }

        switch (rule.contentType) {
          case 'video':
            return VideoPage(
              rule: rule,
              item: widget.searchItem.item,
              jsContext: jsContext,
            );
            break;
          case 'thumbnail':
            return ThumbnailDetailPage(
              rule: rule,
              item: widget.searchItem.item,
              jsContext: jsContext,
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: Text('contentType error'),
              ),
              body: ShowError(
                errorMsg:
                    'undefined contentType of ${rule.contentType} in rule ${rule.name}',
              ),
            );
        }
      },
    );
  }
}