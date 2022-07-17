
import 'package:carismatic/ResponseModel/MainDataClass.dart';
import 'package:carismatic/ui/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:carismatic/ui/account/tab_account.dart';
import 'package:carismatic/ui/home/tab_home.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:carismatic/constants/constant.dart';

import 'home/my_car_collection_screen.dart';


class HomePage extends StatefulWidget {
   HomePage(this.mainDataList );
   final List<MainDataModel> mainDataList;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedPage = 0;
  List<Widget> pages = [
    // TabHomePage(),
    SearchScreen(ll: COnstantMainDataList),
    MyCarCollectionScreen(),
    //HomeScreen(),
    //MainPage(),
    TabAccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    COnstantMainDataList=widget.mainDataList;
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() { _selectedPage = index; }),
        controller: _pageController,
        children: [
          ...pages
        ],
      ),
      bottomNavigationBar: FlashyTabBar(
        height: 60,
        selectedIndex: _selectedPage,
        showElevation: false,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined, size: 24, color: PRIMARY_COLOR,),
            title: const Text('Home',style: TextStyle(fontSize: 10)),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.car_rental, size: 24, color: PRIMARY_COLOR,),
            title: const Text('My Car\nCollection',style: TextStyle(fontSize: 10),),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.account_circle_outlined, size: 24, color: PRIMARY_COLOR,),
            title: const Text('Account',style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
