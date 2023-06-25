//import 'dart:html' as html;
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:dlsm_web/globalVar.dart' as globalVar;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List userList = [];
  List rebateRecords = [];
  var anchor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    /* return ListView.builder(
        itemCount: userList == [] ? 0 : userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ListTile(
            title: Text(userList[index]['_id']),
            subtitle: Text(
                "${userList[index]['email']} ${userList[index]['phoneNumber']}"),
            trailing: TextButton(
              child: const Text("Download Report"),
              onPressed: () {
                generateReport(userList[index]['_id']);
              },
            ),
          ));
        }); */
    return Placeholder();
  }

  // void getData() async {
  //   try {
  //     var response = await Dio()
  //         .get('https://drive-less-save-more-1.herokuapp.com/admin/dashboard',
  //             options: Options(headers: {
  //               "Access-Control-Allow-Origin": "*",
  //               "Content-Type": "application/json",
  //               "Authorization": "Bearer ${globalVar.token}",
  //             }));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         userList = response.data as List;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // generateReport(uId) async {
  //   await fetchRebate(uId);
  //   final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
  //   final ttf = pw.Font.ttf(font);
  //   var tableContent;
  //   if (rebateRecords.length == 0) {
  //     tableContent = [
  //       pw.TableRow(children: [pw.Text("No rebate records")])
  //     ];
  //   } else {
  //     tableContent = rebateRecords
  //         .map(
  //           (e) => pw.TableRow(
  //             children: <pw.Widget>[
  //               pw.Container(
  //                   height: 32, child: pw.Text(e['campaign'].toString())),
  //               pw.Container(
  //                   height: 32,
  //                   child: pw.Text(DateFormat("yyyy-MM-dd h:mm:ss a")
  //                       .format(DateTime.parse(e['requestedDate'])))),
  //               pw.Container(
  //                   height: 32, child: pw.Text(e['rebateType'].toString())),
  //               pw.Container(height: 32, child: pw.Text(e['status'])),
  //             ],
  //           ),
  //         )
  //         .toList();
  //   }

  //   final pdf = pw.Document();
  //   pdf.addPage(pw.Page(
  //     build: (pw.Context context) =>
  //         pw.Table(border: pw.TableBorder.all(), children: [
  //       pw.TableRow(children: [
  //         pw.Container(height: 32, child: pw.Text('User ID')),
  //         pw.Container(height: 32, child: pw.Text(uId))
  //       ]),
  //       pw.TableRow(
  //         children: <pw.Widget>[
  //           pw.Container(height: 32, child: pw.Text('Campaign')),
  //           pw.Container(height: 32, child: pw.Text('Requested Date')),
  //           pw.Container(height: 32, child: pw.Text('Rebate Type')),
  //           pw.Container(height: 32, child: pw.Text("Status")),
  //         ],
  //       ),
  //       ...tableContent
  //     ]),
  //   ));

  //   await savePDF(uId, pdf);
  // }

  // savePDF(uId, pdf) async {
  //   Uint8List pdfInBytes = await pdf.save();
  //   final blob = html.Blob([pdfInBytes], 'application/pdf');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //   anchor = html.document.createElement('a') as html.AnchorElement
  //     ..href = url
  //     ..style.display = 'none'
  //     ..download = '$uId Rebate Report.pdf';
  //   html.document.body!.children.add(anchor);

  //   //to open the pdf
  //   anchor!.click();
  // }

  // fetchRebate(uId) async {
  //   try {
  //     var response = await Dio()
  //         .get('https://drive-less-save-more-1.herokuapp.com/view/records/$uId',
  //             options: Options(headers: {
  //               "Access-Control-Allow-Origin": "*",
  //               "Content-Type": "application/json",
  //               "Authorization": "Bearer ${globalVar.token}",
  //             }));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         var data = response.data
  //             .where((i) => i["user"] == uId)
  //             .map((e) => e["rebateRecords"]);
  //         data.forEach(
  //             (nums) => nums.forEach((number) => rebateRecords.add(number)));
  //         print(rebateRecords);
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
