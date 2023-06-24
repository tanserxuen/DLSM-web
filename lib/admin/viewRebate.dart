import 'package:dlsm_web/admin/services/rebate_service.dart';
import 'package:flutter/material.dart';

import 'model/rebate.dart';

class RebatePage extends StatefulWidget {
  const RebatePage({super.key});

  @override
  State<RebatePage> createState() => _RebatePageState();
}

class _RebatePageState extends State<RebatePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Rebate>>(
        future: RebateService().fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RebateService().buildTable(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
