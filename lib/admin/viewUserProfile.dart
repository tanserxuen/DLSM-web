import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/services/dio_service.dart';
 import '../globalVar.dart' as globalVar;

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  
  List userList = [];
  Dio get _dio => ref.read(dioServiceProvider).backendDio;

    void getData() async {
    try {

      Response response = await _dio.get(
        'admin/dashboard',
      );
      print (response);
      if (response.statusCode == 200) {
        this.setState(() {
          userList = response.data as List;
          print('userlist\n');
         print(userList);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future initState() async{
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Text('User Details')
          .fontSize(20)
          .padding(top: 10, left: 10),
      DataTable(
        columns: [
          _dataColumn('ID'),
          _dataColumn('Full Name'),
          _dataColumn('Nick Name'),
          _dataColumn('Email'),
          _dataColumn('Phone No'),
          _dataColumn('ID No'),
        ],
        rows: [
          _dataRow('1', 'name', 'name', 'email', 'phone', '12937298632', isEvenRow: false),
          _dataRow('1', 'name', 'name', 'email', 'phone', 'EH231231',isEvenRow: true),
          for (int i = 0; i < userList.length; i++)
            if (userList[i]['role'] == 'user')
              _dataRow(
                userList[i]['_id'],
                userList[i]['fullname'],
                userList[i]['nickname'],
                userList[i]['email'],
                userList[i]['phoneNumber'],
                userList[i]['idNo'],
                isEvenRow: i % 2 == 0,
              )
        ],
      ),
    ].toColumn().alignment(Alignment.topLeft);
  }

  DataColumn _dataColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  DataRow _dataRow(String id, String fullname,String nickname, String email, String phone, String idNo,
      {required bool isEvenRow}) {
    final backgroundColor = isEvenRow
        ? Color.fromARGB(255, 166, 203, 234).withOpacity(0.2)
        : Colors.white;
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(id)),
        DataCell(Text(fullname)),
        DataCell(Text(nickname)),
        DataCell(Text(email)),
        DataCell(Text(phone)),
        DataCell(Text(idNo)),
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
