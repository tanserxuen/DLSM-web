import 'package:dlsm_web/user/index.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends ConsumerStatefulWidget {
  const SideBarMenu({
    super.key,
    required this.sideMenu,
  });

  final SideMenuController sideMenu;

  @override
  ConsumerState<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends ConsumerState<SideBarMenu> {
  UserState get _userState => ref.read(userStateProvider);

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      controller: widget.sideMenu,
      style: SideMenuStyle(
        // showTooltip: false,
        displayMode: SideMenuDisplayMode.auto,
        hoverColor: Colors.blue[100],
        selectedColor: Colors.lightBlue,
        selectedTitleTextStyle: const TextStyle(color: Colors.white),
        selectedIconColor: Colors.white,
      ),
      title: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150,
              maxWidth: 150,
            ),
            child: FittedBox(
                    child: Image.asset('assets/imgs/logo_title.png',
                        fit: BoxFit.fill))
                .padding(left: 30, top: 10),
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Welcome , ${_userState.value!.fullName}",
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, wordSpacing: 2),
        ),
      ),
      items: [
        SideMenuItem(
          priority: 0,
          title: 'Statistics',
          onTap: (page, _) {
            widget.sideMenu.changePage(page);
          },
          icon: const Icon(Icons.bar_chart),
        ),
        SideMenuItem(
          priority: 1,
          title: 'Rebate',
          onTap: (page, _) {
            widget.sideMenu.changePage(page);
          },
          icon: const Icon(Icons.money),
        ),
        SideMenuItem(
          priority: 2,
          title: 'User Profile',
          onTap: (page, _) {
            widget.sideMenu.changePage(page);
          },
          icon: const Icon(Icons.person),
        ),
        SideMenuItem(
          priority: 3,
          title: 'Report',
          onTap: (page, _) {
            widget.sideMenu.changePage(page);
          },
          icon: const Icon(Icons.file_open),
        ),
      ],
    );
  }
}
