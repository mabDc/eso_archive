import 'package:flutter/material.dart';
import '../global/global.dart';
import 'about_page.dart';
import 'discover_page.dart';
import 'home_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = "text";
    final icon = "icon";
    final navigationItems = [
      {text: "home", icon: Icons.library_books},
      {text: "discover", icon: Icons.satellite},
      {text: "about", icon: Icons.info_outline},
    ];

    List<Widget> pages = <Widget>[
      HomePage(),
      DiscoverPage(),
      AboutPage(),
    ];

    return Scaffold(
      body: Global().option.enTabBar
          ? TabBarView(
              controller: _tabController,
              children: pages,
            )
          : pages[_currentIndex],
      bottomNavigationBar: Global().option.enTabBar
          ? Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryTextTheme.title.color,
                labelColor: Theme.of(context).primaryTextTheme.title.color,
                unselectedLabelColor: Theme.of(context)
                    .primaryTextTheme
                    .title
                    .color
                    .withOpacity(0.75),
                tabs: navigationItems
                    .map(
                        (item) => Tab(text: item[text], icon: Icon(item[icon])))
                    .toList(),
              ),
            )
          : BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).primaryTextTheme.title.color,
              unselectedItemColor: Theme.of(context)
                  .primaryTextTheme
                  .title
                  .color
                  .withOpacity(0.75),
              items: navigationItems
                  .map((item) => BottomNavigationBarItem(
                      title: Text(item[text]), icon: Icon(item[icon])))
                  .toList(),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
    );
  }
}
