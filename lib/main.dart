import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'global/global.dart';
import 'global/profile_change_notifier.dart';
import 'pages/about_page.dart';
import 'pages/discover_page.dart';
import 'pages/home_page.dart';
import 'pages/show_error.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: SettingModel()),
        ChangeNotifierProvider.value(value: PageModel()),
      ],
      child: Consumer2<ThemeModel, PageModel>(
          builder: (BuildContext context, themeModel, pageModel, Widget child) {
        final theme = ThemeData(
          primaryColor: Color(themeModel.color),
          brightness:
              themeModel.enDarkMode ? Brightness.dark : Brightness.light,
        );
        return MaterialApp(
          theme: theme,
          home: Scaffold(
            body: PageView(
              children: [
                HomePage(),
                DiscoverPage(),
                AboutPage(),
              ],
              controller: pageModel.pageController,
              onPageChanged: (index) {
                //pageModel.changePage(index, false);
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: theme.primaryColor,
              selectedItemColor: theme.primaryTextTheme.title.color,
              unselectedItemColor:
                  theme.primaryTextTheme.title.color.withOpacity(0.75),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), title: Text('home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.satellite), title: Text('discover')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline), title: Text('about')),
              ],
              currentIndex: pageModel.currentIndex,
              onTap: (index) {
                pageModel.changePage(index);
              },
            ),
          ),
        );
      }),
    );
  }
}
