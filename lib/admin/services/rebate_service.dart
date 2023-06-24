import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/rebate.dart';

class RebateService {
  Future<List<Rebate>> fetchData() async {
    final response = await Dio().get(
        'https://drive-less-save-more-1.herokuapp.com/api#/Rebate/RebateController_getAllRebate');

    final data = response.data as List<dynamic>;
    final List<Rebate> dataList = data.map((e) => Rebate.fromJson(e)).toList();

    return dataList;
  }

  Widget buildTable(List<Rebate> dataList) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('User')),
        DataColumn(label: Text('Participant Record')),
        DataColumn(label: Text('Campaign')),
        DataColumn(label: Text('Requested Date')),
        DataColumn(label: Text('Rebate Type')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('__v')),
      ],
      rows: dataList.map((data) {
        return DataRow(cells: [
          DataCell(Text(data.id)),
          DataCell(Text(data.user)),
          DataCell(Text(data.participantRecord)),
          DataCell(Text(data.campaign)),
          DataCell(Text(data.requestedDate.toString())),
          DataCell(Text(data.rebateType)),
          DataCell(Text(data.status)),
          DataCell(Text(data.v.toString())),
        ]);
      }).toList(),
    );
  }
}
