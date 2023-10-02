// ignore_for_file: must_call_super, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  ///
  int _selectedPage = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  void navigationItemOnTap(int page) {
    pageController.jumpToPage(page);
  }

  // void getFirebaseData() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   username = (snap.data() as Map<String, dynamic>)['username'];
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: mobileBackgroundColor,
          type: BottomNavigationBarType.fixed,
          onTap: navigationItemOnTap,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedPage == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _selectedPage == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _selectedPage == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _selectedPage == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedPage == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
