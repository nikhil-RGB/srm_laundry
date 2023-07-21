import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:laundry_counter/pages/CounterPage.dart';
import 'package:laundry_counter/pages/colors.dart';
import 'package:laundry_counter/pages/models/BagDataModel.dart';

class DatePage extends StatefulWidget {
  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  late Box<BagDataModel> laundryBox;
  @override
  void initState() {
    super.initState();
    laundryBox = Hive.box<BagDataModel>("laundry_log");
  }

  @override
  Widget build(BuildContext context) {
    Iterable<String> keys = laundryBox.keys.cast();
    return Scaffold(
      backgroundColor: darkMode ? darkModeBg : lightModeBg,
      body: ListView.builder(
          itemCount: keys.length,
          itemBuilder: ((context, index) {
            return dateTile(keys.elementAt(index));
          })),
    );
  }

  //builds a tile which has a date on it, when clicked takes user to counter page for that day
  Widget dateTile(String key) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: color),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      CounterPage.openPrevious(model: laundryBox.get(key)!))),
              (Route<dynamic> route) => false,
            );
          },
          child: ListTile(
            title: Center(
              child: Text(
                key,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: darkMode ? darkModeFg : lightModeFg),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }
}
