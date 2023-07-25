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
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkMode ? darkModeBg : lightModeBg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: color,
            ),
          ),
          title: Text(
            "All Entries",
            style: TextStyle(
                color: darkMode ? darkModeFg : lightModeFg,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: (keys.length != 0)
            ? ListView.builder(
                itemCount: keys.length,
                itemBuilder: ((context, index) {
                  return dateTile(keys.elementAt(index));
                }))
            : Center(
                child: Text(
                  "Nothing to see here!",
                  style: TextStyle(color: darkMode ? darkModeFg : lightModeFg),
                ),
              ),
      ),
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
            leading: const SizedBox(width: 20),
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
            trailing: IconButton(
              color: Colors.redAccent,
              icon: Icon(Icons.delete_forever_rounded),
              onPressed: () {
                setState(() {
                  laundryBox.delete(key);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
