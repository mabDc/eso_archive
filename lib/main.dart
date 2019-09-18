import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'pages/navigation_page.dart';
import 'global/global.dart';
import 'pages/show_error.dart';
import 'global/profile_change_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
    Global.init().then((e) async {
      ErrorWidget.builder = (FlutterErrorDetails err) {
        String errorMsg = err.toString();
        return ShowError(errorMsg: errorMsg);
      };
      runApp(MyApp());
      if (Platform.isAndroid) {
        // 以下两行
        // 设置android状态栏为透明的沉浸。
        // 写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏
        // 写在渲染之前，MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: SettingModel()),
      ],
      child: Consumer2<ThemeModel, SettingModel>(builder:
          (BuildContext context, themeModel, settingModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: Color(themeModel.color),
            brightness:
                themeModel.enDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: NavigationPage(),
        );
      }),
    );
  }
}
