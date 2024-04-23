import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:interview_demo/model.dart';

class TransactionReportController extends GetxController {
  var transactionReports = [].obs;

  void fetchTransactionReports() async {
    try {
      var url = Uri.parse('https://paytelrms.com/api/v1/report/transactionReport');
      var response = await http.post(
        url,
        body: jsonEncode({
          "latLong": "1:12:2,21:1:3",
          "deviceId": "AC-ED-5C-67-68-17",
          "deviceName": "Mobile",
          "pin": "1212",
          "mode": "Android",
          "merchantID": "14",
          "branch_id": "1",
          "floor_id": "",
          "table_id": "",
          "from_date": "",
          "to_date": "",
          "status": "",
          "order_type": "dinein"
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var respString = jsonResponse['respString'] as List;
        transactionReports.value = respString
            .map((transactionReport) => TransactionReport.fromJson(transactionReport))
            .toList();
      } else {
        throw Exception('Failed to load transaction reports');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TransactionReportTable extends StatelessWidget {
  final controller = Get.put(TransactionReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => controller.fetchTransactionReports(),
              child: Text('Fetch Transaction Reports'),
            ),
            Expanded(
              child: Obx(
                    () => DataTable(
                  columns: [
                    DataColumn(label: Text('Bill')),
                    DataColumn(label: Text('Order')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Floor Name')),
                    DataColumn(label: Text('Table Name')),
                  ],
                  rows: controller.transactionReports.map<DataRow>((transactionReport) {
                    return DataRow(
                      cells: [
                        DataCell(Text(transactionReport.bill)),
                        DataCell(Text(transactionReport.order)),
                        DataCell(Text(transactionReport.amount.toString())),
                        DataCell(Text(transactionReport.date)),
                        DataCell(Text(transactionReport.status)),
                        DataCell(Text(transactionReport.floorName)),
                        DataCell(Text(transactionReport.tableName)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


