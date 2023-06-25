// ignore_for_file: library_private_types_in_public_api

import 'package:dlsm_web/admin/view/viewRebate.dart';
import 'package:dlsm_web/admin/view/viewReport.dart';
import 'package:dlsm_web/admin/view/viewUserProfile.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:dlsm_web/admin/widgets/menuItems.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideBarMenu(sideMenu: sideMenu),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                RebatePage(),
                ProfilePage(),
                ReportPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
