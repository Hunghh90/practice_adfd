import 'package:flutter/material.dart';
import 'package:practice_adfd/detail_page.dart';
import 'package:practice_adfd/home_page.dart';
import 'package:practice_adfd/search.dart';
import 'package:practice_adfd/tool_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  int _curentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: _curentIndex,
              children:[
                const HomePage(),
                SearchPage(),
                ToolPage(),
                DetailPage(),
              ],
            ),
            bottomNavigationBar: SalomonBottomBar(
                currentIndex: _curentIndex,
                onTap: (index){
                  setState(() {
                    _curentIndex = index;
                  });
                },
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                items: [
                  SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("Home")),
                  SalomonBottomBarItem(icon: Icon(Icons.search), title: Text("Search")),
                  SalomonBottomBarItem(icon: Icon(Icons.pan_tool), title: Text("Search")),
                  SalomonBottomBarItem(icon: Icon(Icons.details), title: Text("Setting")),
                ]
            ),
      )
      ),
    );
  }
}
