import 'package:flutter/material.dart';
import '../ui/primary_color_text.dart';
import '../ui/option_switch.dart';
import '../global/global.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
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
                OptionSwitch(
                  title: Text('Tap Bar Navigator'),
                  value: Global().setting.enTabBar,
                  onChange: (value) async {
                    Global().setting.enTabBar = value;
                    await Global().saveSetting();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().setting.enTabBar = !Global().setting.enTabBar;
                    await Global().saveSetting();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Auto Refresh'),
                  subtitle: Text('not yet'),
                  value: Global().setting.enAutoRefresh,
                  onChange: (value) async {
                    Global().setting.enAutoRefresh = value;
                    await Global().saveSetting();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().setting.enAutoRefresh =
                        !Global().setting.enAutoRefresh;
                    await Global().saveSetting();
                    setState(() {});
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
                OptionSwitch(
                  title: Text('Full Screen'),
                  subtitle: Text('also apply in thumbnail and video'),
                  value: Global().setting.enFullScreen,
                  onChange: (value) async {
                    Global().setting.enFullScreen = value;
                    await Global().saveSetting();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().setting.enFullScreen =
                        !Global().setting.enFullScreen;
                    await Global().saveSetting();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Volume Control'),
                  subtitle: Text('not yet'),
                  value: Global().setting.enVolumeControl,
                  onChange: (value) async {
                    Global().setting.enVolumeControl = value;
                    await Global().saveSetting();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().setting.enVolumeControl =
                        !Global().setting.enVolumeControl;
                    await Global().saveSetting();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Flipping Animation'),
                  subtitle: Text('not yet'),
                  value: Global().setting.enFlippingAnimation,
                  onChange: (value) async {
                    Global().setting.enFlippingAnimation = value;
                    await Global().saveSetting();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().setting.enFlippingAnimation =
                        !Global().setting.enFlippingAnimation;
                    await Global().saveSetting();
                    setState(() {});
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
