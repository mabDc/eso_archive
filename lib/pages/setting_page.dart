import 'package:flutter/material.dart';
import '../ui/primary_color_text.dart';
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
            title: PrimaryColorText('home settings'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Tap Bar Navigator'),
                  value: setting.enTabBar,
                  onChanged: (value) async {
                    setting.enTabBar = value;
                  },
                ),
                SwitchListTile(
                  title: Text('Auto Refresh'),
                  value: setting.enAutoRefresh,
                  onChanged: (value) async {
                    setting.enAutoRefresh = value;
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('content settings'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text('Full Screen'),
                  subtitle: Text('also apply in thumbnail and video'),
                  value: setting.enFullScreen,
                  onChanged: (value) async {
                    setting.enFullScreen = value;
                  },
                ),
                SwitchListTile(
                  title: Text('Volume Control'),
                  subtitle: Text('not yet'),
                  value: setting.enVolumeControl,
                  onChanged: (value) async {
                    setting.enVolumeControl = value;
                  },
                ),
                SwitchListTile(
                  title: Text('Flipping Animation'),
                  subtitle: Text('not yet'),
                  value: setting.enFlippingAnimation,
                  onChanged: (value) async {
                    setting.enFlippingAnimation = value;
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('other settings'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('download path'),
                  subtitle: Text('not yet'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
