import 'package:dlsm_web/admin/services/rebate_service.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:flutter/material.dart';

import 'model/participantRecord.dart';
import 'model/rebate.dart';

class RebatePage extends ConsumerStatefulWidget {
  const RebatePage({super.key});

  @override
  ConsumerState<RebatePage> createState() => _RebatePageState();
}

class _RebatePageState extends ConsumerState<RebatePage> {
  RebateService get _rebateService => ref.read(rebateServiceProvider);

  String selectedStatus = 'SUBMITTED';
  List participantRecords = [];
  List rebates = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      List newArray = [];
      List rebateList = await _rebateService.fetchData(selectedStatus);
      for (var rebate in rebateList) {
        var record = await _rebateService.fetchParticipantRecord(
            rebate.user, rebate.campaign);
        newArray.add(record);
      }
      setState(() {
        participantRecords = newArray;
        print(participantRecords);
        rebates = rebateList;
        print(rebates);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final rebateService = ref.read(rebateServiceProvider);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          _buildStatusButton(),
          Expanded(
            child: _buildRebateTable(rebateService, selectedStatus),
          )
        ],
      ),
    );
  }

  Widget _buildStatusButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedStatus = 'SUBMITTED';
            });
          },
          child: Text('Submitted'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedStatus = 'APPROVED';
            });
          },
          child: Text('Approved'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedStatus = 'REJECTED';
            });
          },
          child: Text('Rejected'),
        ),
      ],
    );
  }

  Widget _buildRebateTable(RebateService rebateService, String status) {
    return FutureBuilder<List<Rebate>>(
      future: rebateService.fetchData(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final dataList = snapshot.data!;
          return buildTable(dataList);
        } else {
          return Center(
            child: Text('No data available.'),
          );
        }
      },
    );
  }

  Widget buildTable(List<Rebate> rebateList) {
    List<DataRow> rows = [];
    for (int i = 0; i < rebateList.length; i++) {
      Rebate rebate = rebateList[i];
      ParticipantRecord record = participantRecords[i];
      rows.add(DataRow(cells: [
        DataCell(Text(rebate.id)),
        DataCell(Text(rebate.user)),
        DataCell(Text(rebate.participantRecord)),
        DataCell(Text(rebate.campaign)),
        DataCell(Text(rebate.requestedDate.toString())),
        DataCell(Text(rebate.rebateType)),
        DataCell(
          rebate.rebateType == 'SAFE_DRIVER_REBATE'
              ? Text(record.totalOverallScore.toString())
              : Text(record.totalDistance.toString()),
        ),
        DataCell(
          rebate.status == 'SUBMITTED'
              ? Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _rebateService.handleApproval(rebate);
                        setState(() {});
                      },
                      child: Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _rebateService.handleRejection(rebate);
                        setState(() {});
                      },
                      child: Text('Reject'),
                    ),
                  ],
                )
              : Text(rebate.status),
        ),
      ]));
    }

    return DataTable(
      columns: const [
        // DataColumn(label: Text('ID')),
        // DataColumn(label: Text('User')),
        DataColumn(label: Text('Participant Record')),
        DataColumn(label: Text('Campaign')),
        DataColumn(label: Text('Requested Date')),
        DataColumn(label: Text('Rebate Type')),
        DataColumn(label: Text('Details')),
        DataColumn(label: Text('Status')),
      ],
      rows: rows,
    );
  }
}
