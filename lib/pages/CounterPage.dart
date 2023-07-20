import 'dart:core';
import 'dart:ffi';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:laundry_counter/pages/colors.dart';
import 'package:laundry_counter/pages/models/BagDataModel.dart';

bool darkMode = false;

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  Map<String, int> clothes = {
    "Pants/Bottoms": 0,
    "Shirts/Tops": 0,
    "T-Shirts": 0,
    "Half-Pants/Shorts": 0,
    "Towels": 0,
    "Pillow Covers": 0,
    "Bedsheets": 0,
    "Others": 0,
  };

  int total = 0;
  late Box<BagDataModel> laundryBox;
  @override
  void initState() {
    super.initState();
    laundryBox = Hive.box("laundry_log");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? darkModeBg : lightModeBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkMode ? darkModeBg : lightModeBg,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_outlined,
              color: color,
            )),
        title: const SizedBox(width: 190),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  darkMode = !darkMode;
                });
              },
              icon: const Icon(
                Icons.format_paint_outlined,
                color: color,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: color,
              )),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          buildCounter("Pants/Bottoms"),
          buildCounter("Shirts/Tops"),
          buildCounter("T-Shirts"),
          buildCounter("Half-Pants/Shorts"),
          buildCounter("Towels"),
          buildCounter("Pillow Covers"),
          buildCounter("Bedsheets"),
          buildCounter("Others"),
          buildTotalBar(),
          buildSave(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildCounter(String name) {
    //The particular laundry entry for which this counter is being built
    MapEntry<String, int> entry =
        clothes.entries.firstWhere((element) => element.key == name);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: darkMode ? darkModeFg : lightModeFg),
          ),
          const SizedBox(
            height: 8.5,
          ),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: color),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  // onTap: _decrementCounter,
                  onTap: () {
                    if (entry.value > 0) {
                      setState(() {
                        clothes[entry.key] = entry.value - 1;
                        //update that entry in the map.
                      });
                    }
                  },
                  child: Container(
                    color: color,
                    width: 55,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  '${entry.value}',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: (darkMode) ? darkModeFg : lightModeFg),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      clothes[entry.key] =
                          entry.value + 1; //update that entry in the map.
                    });
                  },
                  child: Container(
                    color: color,
                    width: 55.0,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //The total cothes bar at the bottom of the screen
  Widget buildTotalBar() {
    int total = 0;
    for (var element in clothes.entries) {
      total += element.value;
    }
    this.total = total;
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
      child: Row(
        children: [
          Text(
            "TOTAL:",
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: darkMode ? darkModeFg : lightModeFg),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            '$total',
            style: const TextStyle(
                fontSize: 27, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  //build save button for app.
  Container buildSave() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          onPressed: () {
            save();
          },
          child: const Center(
            child: Text(
              "Save",
              style: TextStyle(fontSize: 20),
            ),
          )),
    );
  }

  BagDataModel createHiveObject() {
    return BagDataModel(
      pants: clothes["Pants/Bottoms"]!,
      shirts: clothes["Shirts/Tops"]!,
      tshirts: clothes["T-Shirts"]!,
      shorts: clothes["Half-Pants/Shorts"]!,
      towels: clothes["Towels"]!,
      pillows: clothes["Pillow Covers"]!,
      bedsheets: clothes["Bedsheets"]!,
      others: clothes["Others"]!,
      total: total,
    );
  }

  //Gives the current date in DD/MM/YYYY format.
  static String currentDate() {
    DateTime today = DateTime.now();
    String dateStr = "${today.day}-${today.month}-${today.year}";
    return dateStr;
  }

  //Saves the current data to local storage via Hive
  void save() {
    laundryBox.put(currentDate(), createHiveObject());
    Logger().w("Length=${laundryBox.keys.length}");
    Logger().wtf("current entry=${laundryBox.get(currentDate())}");
  }
}
