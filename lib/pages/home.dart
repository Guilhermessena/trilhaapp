import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trilhaapp/pages/menu_drawer.dart';
import 'package:trilhaapp/pages/num_pages.dart';

import 'card_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageController = PageController();
  var posPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Meu app",
            style: GoogleFonts.roboto(),
          ),
        ),
        drawer: const MenuDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: pageController,
                  onPageChanged: (value) => setState(() {
                        posPage = value;
                      }),
                  children: const [
                    CardPage(),
                    NumPage2(),
                    NumPage3(),
                  ]),
            ),
            BottomNavigationBar(
              onTap: (value) => pageController.jumpToPage(value),
              currentIndex: posPage,
              items: const [
                BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: "Dados", icon: Icon(Icons.add)),
                BottomNavigationBarItem(
                    label: "User", icon: Icon(Icons.person)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
