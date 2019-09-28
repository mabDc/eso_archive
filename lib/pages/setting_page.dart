import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/profile_change_notifier.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              '正文选项',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              'content settings',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('阅览时全屏'),
                  subtitle: Text('Full Screen'),
                  value: setting.enFullScreen,
                  onChanged: (value) async {
                    setting.enFullScreen = value;
                  },
                ),
                SwitchListTile(
                  title: Text('音量键控制正文切换'),
                  subtitle: Text('Volume Control'),
                  value: setting.enVolumeControl,
                  onChanged: (value) async {
                    setting.enVolumeControl = value;
                  },
                ),
                SwitchListTile(
                  title: Text('翻页动画'),
                  subtitle: Text('Flipping Animation'),
                  value: setting.enFlippingAnimation,
                  onChanged: (value) async {
                    setting.enFlippingAnimation = value;
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              '主页选项',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              'home settings',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('允许左右滑动切换页面'),
                  subtitle: Text('Navigator'),
                  value: setting.enTabBar,
                  onChanged: (value) async {
                    setting.enTabBar = value;
                  },
                ),
                SwitchListTile(
                  title: Text('启动时自动刷新'),
                  subtitle: Text('Auto Refresh'),
                  value: setting.enAutoRefresh,
                  onChanged: (value) async {
                    setting.enAutoRefresh = value;
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              '其他选项',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            subtitle: Text(
              'other settings',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('下载路径'),
                  subtitle: Text('download path'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
