// import 'dart:ffi';

import '../../common/index.dart';

class StaItem extends StatelessWidget {
  final String title;
  final int value;

  const StaItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 05),
      child: Container(
        width: 270,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "$value",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
