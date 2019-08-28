import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}













/*

import 'package:flutter/material.dart';
import '../ui/custom_listItem_two.dart';
import '../utils/search_item.dart';
import 'package:flutter_liquidcore/liquidcore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _jsContext = JSContext();
  final items = <Map<String, dynamic>>[];
  final _textEditingController = TextEditingController(text: ''
      
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('亦搜'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(labelText: 'js code'),
              controller: _textEditingController,
              minLines: 1,
              maxLines: 12345,
            ),
          ),
          RaisedButton(
            child: Text('js 异步搜索并显示'),
            onPressed: () async {
              try {
                //await _jsContext.setProperty('items', items);
                dynamic result = await _jsContext
                    .evaluateScript(_textEditingController.text);
                if (!result is List) {
                  result = [result];
                }
                print(result);
              } catch (e) {
                print(e);
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = SearchItem.fromMap(items[index]);
                return CustomListItemTwo(
                  thumbnail: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                  ),
                  title: item.title,
                  subtitle: item.subtitle,
                  author: item.author,
                  publishDate: item.publishDate,
                  readDuration: item.readDuration,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_jsContext != null) {
      // Free up the context resources.
      _jsContext.cleanUp();
    }
    super.dispose();
  }
}

// ...

Widget build(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(10.0),
    children: <Widget>[
      CustomListItemTwo(
        thumbnail: Container(
          decoration: const BoxDecoration(color: Colors.pink),
        ),
        title: 'Flutter 1.0 Launch',
        subtitle: 'Flutter continues to improve and expand its horizons.'
            'This text should max out at two lines and clip',
        author: 'Dash',
        publishDate: 'Dec 28',
        readDuration: '5 mins',
        onTap: () => print('tap Flutter 1.0 Launch'),
      ),
      CustomListItemTwo(
        thumbnail: Container(
          decoration: const BoxDecoration(color: Colors.blue),
        ),
        title: 'Flutter 1.2 Release - Continual updates to the framework',
        subtitle: 'Flutter once again improves and makes updates.',
        author: 'Flutter',
        publishDate: 'Feb 26',
        readDuration: '12 mins',
      ),
    ],
  );
}


*/