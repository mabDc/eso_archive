import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global/global.dart';
import 'pages/theme_proxy_page.dart';

void main() async {
  await Global().init();
  runApp(ThemeProxyPage());
  if (Platform.isAndroid) {
    // 以下两行
    // 设置android状态栏为透明的沉浸。
    // 写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏
    // 写在渲染之前，MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
