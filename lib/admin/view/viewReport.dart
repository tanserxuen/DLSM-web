import 'dart:html' as html;
import 'dart:typed_data';
import 'package:dlsm_web/admin/services/generate_report_service.dart';
import 'package:dlsm_web/admin/services/view_user_profile_service.dart';
import 'package:dlsm_web/admin/states/report_list_state.dart';
import 'package:dlsm_web/admin/states/user_list_state.dart';
import 'package:dlsm_web/common/index.dart';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({super.key});

  @override
  ConsumerState<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  Logger get _logger => ref.read(loggerServiceProvider);
  UserProfileService get _userProfileService =>
      ref.read(userProfileServiceProvider);
  UserListStateNotifier get _userStateNotifier =>
      ref.read(userListStateProvider.notifier);
  GenerateReportService get _generateReportService =>
      ref.read(generateReportServiceProvider);
  ReportListStateNotifier get _reportStateNotifier =>
      ref.read(reportListStateProvider.notifier);
  var anchor;
  final padding = pw.EdgeInsets.all(5);
  final headerColor = PdfColors.blue300;

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
    final userList = userListState.userList!;
    final rebateListState = ref.watch(generateReportServiceProvider);

    return ListView.builder(
        itemCount: userList == [] ? 0 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            title: Text(userList[index].fullName),
            subtitle:
                Text("${userList[index].email} ${userList[index].phoneNumber}"),
            trailing: TextButton(
              child: const Text("Download Report"),
              onPressed: () async {
                generateReport(userList[index].id, rebateListState);
              },
            ),
          ));
        });
  }

  generateTableRow(el) {
    return pw.Table(border: pw.TableBorder.all(), children: [
      //campaign header
      pw.TableRow(
        children: <pw.Widget>[
          pw.Container(
              height: 32,
              child: pw.Text('Total Distance'),
              padding: padding,
              color: headerColor),
          pw.Container(
              height: 32,
              child: pw.Text('Total Overall Score'),
              padding: padding,
              color: headerColor),
          pw.Container(
              height: 32,
              child: pw.Text("Total Speeding Score"),
              padding: padding,
              color: headerColor),
          pw.Container(
              height: 32,
              child: pw.Text("Total Acceleration Score"),
              padding: padding,
              color: headerColor),
          pw.Container(
              height: 32,
              child: pw.Text("Total Braking Score"),
              padding: padding,
              color: headerColor),
        ],
      ),
      //campaign data
      pw.TableRow(children: [
        pw.Container(
            height: 32,
            child: pw.Text(
                el!['totalDistance'] ? el!['totalDistance'].toString() : ""),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el!['totalOverallScore']
                ? el!['totalOverallScore'].toString()
                : ""),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el!['totalSpeedingScore']
                ? el!['totalSpeedingScore'].toString()
                : ""),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el!['totalAccelerationScore']
                ? el!['totalAccelerationScore'].toString()
                : ""),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el!['totalBrakingScore']
                ? el!['totalBrakingScore'].toString()
                : ""),
            padding: padding),
      ]),
    ]);
  }

  generateRecordsTable(el) {
    List rebateRows = [];
    if (el!['rebateRecords'].length > 0) {
      rebateRows.add(
        pw.TableRow(children: [
          pw.Container(
              height: 32,
              child: pw.Text("Rebate Records List"),
              padding: padding),
        ]),
      );
      rebateRows.add(pw.TableRow(children: [
        pw.Container(
            height: 32,
            child: pw.Text("Requested Date"),
            padding: padding,
            color: headerColor),
        pw.Container(
            height: 32,
            child: pw.Text("Rebate Type"),
            padding: padding,
            color: headerColor),
        pw.Container(
            height: 32,
            child: pw.Text("Status"),
            padding: padding,
            color: headerColor),
      ]));
      for (var i = 0; i < el!['rebateRecords'].length; i++) {
        var e = el!['rebateRecords'][i];

        rebateRows.add(pw.TableRow(children: [
          pw.Container(
              height: 32,
              child: pw.Text(
                  e!['requestedDate'] ? e['requestedDate']!.toString() : ""),
              padding: padding),
          pw.Container(
              height: 32,
              child:
                  pw.Text(e!['rebateType'] ? e['rebateType']!.toString() : ""),
              padding: padding),
          pw.Container(
              height: 32,
              child: pw.Text(e!['status'] ? e['status']!.toString() : ""),
              padding: padding),
        ]));
      }
    } else {
      rebateRows.add(pw.TableRow(children: [
        pw.Container(
            height: 32, child: pw.Text("No Rebate Records"), padding: padding),
      ]));
    }

    return pw.Table(border: pw.TableBorder.all(), children: [...rebateRows]);
  }

  generateReport(uId, rebateListState) async {
    List rebateList = [];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _generateReportService.fetchRebate(uId);

      rebateList = rebateListState.rebateList!;
      print("sejhdkcxjkaudjnxiaksux");
    });
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    var tableContent = [];
    print("wdnjcssssssssssssssssssssssssssssssssssssssssssssssssssssk");
    print(rebateList);
    if (rebateList.isEmpty) {
      tableContent.add(pw.Text("No Rebate Records"));
    } else {
      rebateList.forEach((element) {
        tableContent.add(pw.Padding(
          child: pw.Text("Campaign: ${element!['campaign']}"),
          padding: const pw.EdgeInsets.all(5),
        ));
        tableContent.add(generateTableRow(element));
        tableContent.add(generateRecordsTable(element));
        tableContent.add(pw.SizedBox(height: 32));
      });
    }

    final pdf = pw.Document();
    // Uint8List imageData = Uint8List(0);

    // await rootBundle
    //     .load('assets/logo/dlsm.png.jpg')
    //     .then((data) => setState(() => imageData = data.buffer.asUint8List()));
    // final image = imageData.buffer.asUint8List();
    pdf.addPage(pw.Page(
      pageTheme: pw.PageTheme(pageFormat: PdfPageFormat.a4.landscape),
      build: (pw.Context context) => pw.Column(children: [
        pw.Text("User ID: $uId"),
        // pw.Image(pw.MemoryImage(image)),
        pw.SizedBox(height: 32),
        ...tableContent
      ]),
    ));

    await savePDF(uId, pdf);
  }

  savePDF(uId, pdf) async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '$uId Rebate Report.pdf';
    html.document.body!.children.add(anchor);

    //to open the pdf
    anchor!.click();
  }
}
