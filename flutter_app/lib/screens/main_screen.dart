import 'package:flutter/material.dart';
import 'package:today_workout/screens/create_feeds_screen.dart';
import 'package:today_workout/screens/feed_screen.dart';
import 'package:today_workout/screens/home_screen.dart';
import 'package:today_workout/screens/profile_screen.dart';
import 'package:today_workout/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    FeedPage(),
    CreateFeedsPage(),
    // TestPage(),
    SearchPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    if (index == 2) {
      openCreateFeed();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void openCreateFeed() async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        // return TestPage();
        return CreateFeedsPage();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text('Logo 2'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.notifications_outlined),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.messenger_outline),
                  ),
                ],
              ),
            )
          : null,
      body: SafeArea(child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        backgroundColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.checklist_outlined),
            icon: Icon(Icons.newspaper_outlined),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Create Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
