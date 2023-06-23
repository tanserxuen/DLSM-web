import 'dart:html';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({
    super.key,
    required this.sideMenu,
  });

  final SideMenuController sideMenu;

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      controller: sideMenu,
      style: SideMenuStyle(
        // showTooltip: false,
        displayMode: SideMenuDisplayMode.auto,
        hoverColor: Colors.blue[100],
        selectedColor: Colors.lightBlue,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        // backgroundColor: Colors.blueGrey[700]
      ),
      title: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150,
              maxWidth: 150,
            ),
            child: Image.asset(
              'assets/images/easy_sidemenu.png',
            ),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      footer: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'mohada',
          style: TextStyle(fontSize: 15),
        ),
      ),
      items: [
        SideMenuItem(
          priority: 0,
          title: 'Rebate',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.money),
          // badgeContent: const Text(
          //   '3',
          //   style: TextStyle(color: Colors.white),
          // ),
          // tooltipContent: "This is a tooltip for Dashboard item",
        ),
        SideMenuItem(
          priority: 1,
          title: 'User Profile',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.person),
        ),
        SideMenuItem(
          priority: 2,
          title: 'Report',
          onTap: (page, _) {
            sideMenu.changePage(page);
          },
          icon: const Icon(Icons.file_open),
          // trailing: Container(
          //     decoration: const BoxDecoration(
          //         color: Colors.amber,
          //         borderRadius: BorderRadius.all(Radius.circular(6))),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
          //       child: Text(
          //         'New',
          //         style: TextStyle(fontSize: 11, color: Colors.grey[800]),
          //       ),
          //     )),
        ),
      ],
    );
  }
}
