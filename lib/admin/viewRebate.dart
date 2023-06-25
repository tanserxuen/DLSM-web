import 'package:dlsm_web/admin/services/rebate_service.dart';
import 'package:dlsm_web/admin/states/rebate_list_state.dart';
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
  List participantRecords = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _rebateService.fetchData("SUBMITTED");
      // for (var rebate in rebateList) {
      //   var record = await _rebateService.fetchParticipantRecord(
      //       rebate.user, rebate.campaign);
      //   newArray.add(record);
      // }
      // setState(() {
      //   participantRecords = newArray;
      //   print(participantRecords);
      //   rebates = rebateList;
      //   print(rebates);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final rebateListState = ref.watch(rebateListStateProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildStatusButton(),
          Expanded(
            child: rebateListState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : rebateListState.rebateList!.isEmpty
                    ? const Center(
                        child:
                            Text('There are cuurently no rebates to display'))
                    : buildTable(rebateListState.rebateList!),
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
            _rebateService.fetchData('SUBMITTED');
          },
          child: const Text('Submitted'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _rebateService.fetchData('APPROVED');
          },
          child: const Text('Approved'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _rebateService.fetchData('REJECTED');
          },
          child: const Text('Rejected'),
        ),
      ],
    );
  }

  Widget buildTable(List<Rebate> rebateList) {
    List<DataRow> rows = [];
    for (int i = 0; i < rebateList.length; i++) {
      Rebate rebate = rebateList[i];
      // ParticipantRecord record = participantRecords[i];
      rows.add(DataRow(cells: [
        DataCell(Text(rebate.user)),
        DataCell(Text(rebate.participantRecord)),
        DataCell(Text(rebate.campaign)),
        DataCell(Text(rebate.requestedDate.toString())),
        DataCell(Text(rebate.rebateType)),
        // DataCell(
        //   rebate.rebateType == 'SAFE_DRIVER_REBATE'
        //       ? Text(record.totalOverallScore.toString())
        //       : Text(record.totalDistance.toString()),
        // ),
        DataCell(
          rebate.status == 'SUBMITTED'
              ? Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _rebateService.handleApproval(rebate);
                        setState(() {});
                      },
                      child: const Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _rebateService.handleRejection(rebate);
                        setState(() {});
                      },
                      child: const Text('Reject'),
                    ),
                  ],
                )
              : Text(rebate.status),
        ),
      ]));
    }
    return DataTable(
      dataRowMaxHeight: 100,
      columnSpacing: 20,
      columns: const [
        // DataColumn(label: Text('ID')),
        DataColumn(label: Text('User')),
        DataColumn(label: Text('Participant Record')),
        DataColumn(label: Text('Campaign')),
        DataColumn(label: Text('Requested Date')),
        DataColumn(label: Text('Rebate Type')),
        DataColumn(label: Text('Status Operation')),
      ],
      rows: rows,
    );
  }
}
