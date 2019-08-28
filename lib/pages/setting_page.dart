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
                  value: Global().option.enTabBar,
                  onChange: (value) async {
                    Global().option.enTabBar = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enTabBar = !Global().option.enTabBar;
                    await Global().saveOption();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Auto Refresh'),
                  value: Global().option.enAutoRefresh,
                  onChange: (value) async {
                    Global().option.enAutoRefresh = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enAutoRefresh =
                        !Global().option.enAutoRefresh;
                    await Global().saveOption();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: PrimaryColorText('reading settings'),
          ),
          Card(
            child: Column(
              children: <Widget>[
                OptionSwitch(
                  title: Text('Full Screen'),
                  value: Global().option.enFullScreen,
                  onChange: (value) async {
                    Global().option.enFullScreen = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enFullScreen =
                        !Global().option.enFullScreen;
                    await Global().saveOption();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Volume Control'),
                  value: Global().option.enVolumeControl,
                  onChange: (value) async {
                    Global().option.enVolumeControl = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enVolumeControl =
                        !Global().option.enVolumeControl;
                    await Global().saveOption();
                    setState(() {});
                  },
                ),
                OptionSwitch(
                  title: Text('Flipping Animation'),
                  value: Global().option.enFlippingAnimation,
                  onChange: (value) async {
                    Global().option.enFlippingAnimation = value;
                    await Global().saveOption();
                    setState(() {});
                  },
                  onTap: () async {
                    Global().option.enFlippingAnimation =
                        !Global().option.enFlippingAnimation;
                    await Global().saveOption();
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
                  subtitle: Text('/root'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
