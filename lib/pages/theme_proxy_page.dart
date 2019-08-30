import 'package:flutter/material.dart';
import 'package:flutter_liquidcore/liquidcore.dart';
import 'navigation_page.dart';
import '../global/global.dart';

class ThemeProxyPage extends StatefulWidget {
  @override
  _ThemeProxyPageState createState() => _ThemeProxyPageState();
}

class _ThemeProxyPageState extends State<ThemeProxyPage> {
  @override
  void initState() {
    super.initState();
    Global().setTheme = setState;
    Global().jsContext = JSContext();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eso',
      theme: ThemeData(
          brightness: Global().option.enBrightnessDark
              ? Brightness.dark
              : Brightness.light,
          //primaryColor: Colors.primaries[Global().option.materialColorIndex]),
          primaryColor: Color(Global().option.colorValue)),
      home: NavigationPage(),
    );
  }

  @override
  void dispose() {
    if (Global().jsContext != null) {
      Global().jsContext.cleanUp();
    }
    super.dispose();
  }
}
