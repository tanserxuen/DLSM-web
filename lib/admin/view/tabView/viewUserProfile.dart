// ignore_for_file: unrelated_type_equality_checks

import 'package:dlsm_web/admin/services/view_user_profile_service.dart';
import 'package:dlsm_web/admin/states/user_list_state.dart';
import 'package:dlsm_web/app/configs/navigator.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Logger get _logger => ref.read(loggerServiceProvider);
  UserProfileService get _userProfileService =>
      ref.read(userProfileServiceProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _userProfileService.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userListState = ref.watch(userListStateProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: userListState.isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: <Widget>[
                const Text('Admin Details')
                    .fontSize(25)
                    .fontWeight(FontWeight.bold)
                    .padding(top: 10, left: 10),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    dataRowMaxHeight: 100,
                    columns: [
                      _dataColumn('ID'),
                      _dataColumn('Full Name'),
                      _dataColumn('Nick Name'),
                      _dataColumn('Email'),
                      _dataColumn('Phone No'),
                      _dataColumn('ID No'),
                      _dataColumn('Action'),
                    ],
                    rows: [
                      for (int i = 0; i < userListState.userList!.length; i++)
                        if (userListState.userList?[i].roles[0] == 'admin')
                          _dataRow(
                            userListState.userList![i].id,
                            userListState.userList![i].fullName,
                            userListState.userList![i].nickName,
                            userListState.userList![i].email,
                            userListState.userList![i].phoneNumber,
                            userListState.userList![i].idNo,
                            userListState.userList![i].roles[0],
                            isEvenRow: i % 2 == 0,
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                const Text('User Details')
                    .fontSize(25)
                    .fontWeight(FontWeight.bold)
                    .padding(top: 10, left: 10),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    dataRowMaxHeight: 100,
                    columns: [
                      _dataColumn('ID'),
                      _dataColumn('Full Name'),
                      _dataColumn('Nick Name'),
                      _dataColumn('Email'),
                      _dataColumn('Phone No'),
                      _dataColumn('ID No'),
                      _dataColumn('Action'),
                    ],
                    rows: [
                      for (int i = 0; i < userListState.userList!.length; i++)
                        if (userListState.userList?[i].roles[0] == 'user')
                          _dataRow(
                            userListState.userList![i].id,
                            userListState.userList![i].fullName,
                            userListState.userList![i].nickName,
                            userListState.userList![i].email,
                            userListState.userList![i].phoneNumber,
                            userListState.userList![i].idNo,
                            userListState.userList![i].roles[0],
                            isEvenRow: i % 2 == 0,
                          ),
                    ],
                  ),
                ),
              ].toColumn().alignment(Alignment.topLeft),
            ),
    );
  }

  DataColumn _dataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  DataRow _dataRow(String id, String fullname, String nickname, String email,
      String phone, String idNo, String role,
      {required bool isEvenRow}) {
    final backgroundColor = isEvenRow
        ? const Color.fromARGB(255, 166, 203, 234).withOpacity(0.2)
        : Colors.white;
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(id)),
        DataCell(Text(fullname)),
        DataCell(Text(nickname)),
        DataCell(Text(email)),
        DataCell(Text('+60 $phone')),
        DataCell(Text(idNo)),
        role == "user"
            ? DataCell(SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      _userProfileService.generateReport(id);
                      onGenerate(id);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text('Rebate Report')),
              ))
            : const DataCell(Text('')),
      ],
      color: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          return backgroundColor;
        },
      ),
    );
  }
}
