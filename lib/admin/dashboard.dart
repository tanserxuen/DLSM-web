import 'package:dio/dio.dart';
import 'package:dlsm_web/admin/viewRebate.dart';
import 'package:dlsm_web/admin/viewReport.dart';
import 'package:dlsm_web/admin/viewUserProfile.dart';
import 'package:dlsm_web/globalVar.dart' as globalVar;
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'menuItems.dart';

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
    signInAsAdmin();
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

  signInAsAdmin() async {
    try {
      var response = await Dio().post(
          'https://drive-less-save-more-1.herokuapp.com/auth/signin',
          data: {"phoneNumber": "1111111111", "password": "1234"});
      if (response.statusCode == 200) {
        setState(() {
          // print(response.data['access_token']);
          globalVar.token = response.data['access_token'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
