import 'package:carrot_market_flutter/page/favorit.dart';
import 'package:carrot_market_flutter/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentPageIndex = 0;
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return const Home();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return MyFavoritContents();
    }
    return Container();
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset("assets/svg/${iconName}_off.svg", width: 22),
        ),
        label: label);
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        items: [
          _bottomNavigationBarItem("home", "홈"),
          _bottomNavigationBarItem("notes", "동내생활"),
          _bottomNavigationBarItem("location", "내 근처"),
          _bottomNavigationBarItem("chat", "채팅"),
          _bottomNavigationBarItem("user", "나의 당근"),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
