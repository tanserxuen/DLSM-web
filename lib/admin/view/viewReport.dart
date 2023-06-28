import 'dart:html' as html;
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:dlsm_web/globalVar.dart' as globalVar;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List userList = [];
  List rebateList = [];
  var anchor;
  final padding = pw.EdgeInsets.all(5);
  final headerColor = PdfColors.blue300;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: userList == [] ? 0 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            title: Text("${userList[index]['fullname']}"),
            subtitle: Text(
                "${userList[index]['email']} ${userList[index]['phoneNumber']}"),
            trailing: TextButton(
              child: const Text("Download Report"),
              onPressed: () {
                generateReport(userList[index]['_id']);
              },
            ),
          ));
        });
  }

  void getData() async {
    try {
      var response = await Dio()
          .get('https://drive-less-save-more-1.herokuapp.com/admin/dashboard',
              options: Options(headers: {
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json",
                "Authorization": "Bearer ${globalVar.token}",
              }));
      if (response.statusCode == 200) {
        setState(() {
          userList = response.data as List;
        });
      }
    } catch (e) {
      print('fetch users $e');
    }
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
            child: pw.Text(el['totalDistance'].toString()),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el['totalOverallScore'].toString()),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el['totalSpeedingScore'].toString()),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el['totalAccelerationScore'].toString()),
            padding: padding),
        pw.Container(
            height: 32,
            child: pw.Text(el['totalBrakingScore'].toString()),
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
              child: pw.Text(e['requestedDate'].toString()),
              padding: padding),
          pw.Container(
              height: 32,
              child: pw.Text(e['rebateType'].toString()),
              padding: padding),
          pw.Container(
              height: 32,
              child: pw.Text(e['status'].toString()),
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

  generateReport(uId) async {
    await fetchRebate(uId);
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    var tableContent = [];
    if (rebateList.isEmpty) {
      tableContent.add(pw.Text("No Rebate Records"));
    } else {
      rebateList.forEach((element) {
        tableContent.add(pw.Padding(
          child: pw.Text("Campaign: ${element['campaign']}"),
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

  fetchRebate(uId) async {
    try {
      var response = await Dio().get(
          'https://drive-less-save-more-1.herokuapp.com/admin/records/$uId',
          options: Options(headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
            "Authorization": "Bearer ${globalVar.token}",
          }));
      if (response.statusCode == 200) {
        setState(() {
          rebateList = response.data as List;
          // .map((e) => e["rebateRecords"]);
          // data.forEach(
          //     (nums) => nums.forEach((number) => rebateRecords.add(number)));
          // print(rebateRecords);
        });
      }
    } catch (e) {
      print('fetch rebate $e');
    }
  }
}
