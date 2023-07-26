import 'dart:core';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laundry_counter/pages/DatePage.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:laundry_counter/pages/colors.dart';
import 'package:laundry_counter/pages/models/BagDataModel.dart';

bool darkMode = false;

// ignore: must_be_immutable
class CounterPage extends StatefulWidget {
  BagDataModel model;
  CounterPage({super.key}) : model = BagDataModel();
  CounterPage.openPrevious({super.key, required this.model});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late Map<String, int> clothes;
  late String date;
  late TextEditingController _bagController;
  late TextEditingController _nameController;

  int total = 0;
  late Box<BagDataModel> laundryBox;
  late Box colorBox;
  @override
  void initState() {
    super.initState();
    laundryBox = Hive.box("laundry_log");
    colorBox = Hive.box("darkMode");
    if (colorBox.isEmpty) {
      colorBox.put("darkMode", false);
    } else {
      darkMode = colorBox.get("darkMode");
    }
    clothes = {
      "Pants/Bottoms": widget.model.pants,
      "Shirts/Tops": widget.model.shirts,
      "T-Shirts": widget.model.tshirts,
      "Half-Pants/Shorts": widget.model.shorts,
      "Towels": widget.model.towels,
      "Pillow Covers": widget.model.pillows,
      "Bedsheets": widget.model.bedsheets,
      "Others": widget.model.others,
    };
    date = widget.model.date;
    _bagController = TextEditingController(text: "${widget.model.bagNo}");
    _nameController = TextEditingController(text: "${widget.model.hostelName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? darkModeBg : lightModeBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkMode ? darkModeBg : lightModeBg,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => DatePage())));
            },
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
                colorBox.put("darkMode", darkMode);
              },
              icon: const Icon(
                Icons.format_paint_outlined,
                color: color,
              )),
          IconButton(
              onPressed: () {
                //come here for refresh implementation
                Iterable<String> keys = clothes.keys;
                setState(() {
                  for (String key in keys) {
                    clothes[key] = 0;
                  }
                });
              },
              icon: const Icon(
                Icons.refresh,
                color: color,
              )),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          dateBar(),
          const SizedBox(
            height: 10,
          ),
          nameField(_nameController, "Hostel Name"),
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
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
          onPressed: () {
            save();
            Fluttertoast.showToast(
                msg: "Entry Saved!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: darkMode ? lightModeBg : darkModeBg,
                textColor: darkMode ? lightModeFg : darkModeFg,
                fontSize: 16.0);
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => DatePage())));
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
      date: date,
      bagNo: int.parse("0" + _bagController.text),
      total: total,
      hostelName: _nameController.text,
    );
  }

  //Saves the current data to local storage via Hive
  void save() {
    laundryBox.put(date, createHiveObject());
    // Logger().w("Length=${laundryBox.keys.length}");
    // Logger().wtf("current entry= Pants${laundryBox.get(currentDate())!.pants}");
  }

  Widget dateBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const SizedBox(
            width: 12.0,
          ),
          Text(
            date,
            style: TextStyle(color: darkMode ? darkModeFg : lightModeFg),
          ),
          const SizedBox(width: 160),
          Text(
            "Bag no.",
            style: TextStyle(color: darkMode ? darkModeFg : lightModeFg),
          ),
          SizedBox(width: 10.0),
          SizedBox(
            width: 60,
            height: 30,
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: darkMode ? darkModeFg : lightModeFg),
                ),
              ),
              controller: _bagController,
              style: TextStyle(color: darkMode ? darkModeFg : lightModeFg),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget nameField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color:
                        (darkMode ? darkModeFg : lightModeFg).withAlpha(100)),
                hintText: "Hostel Name",
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.0, color: darkMode ? darkModeFg : lightModeFg),
                ),
              ),
              controller: _nameController,
              style: TextStyle(color: darkMode ? darkModeFg : lightModeFg),
              keyboardType: TextInputType.name,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Gives the current date in DD/MM/YYYY format.
String currentDate() {
  DateTime today = DateTime.now();
  String dateStr = "${today.day}-${today.month}-${today.year}";
  return dateStr;
}

// String dummyDate(String date) {
//   return date;
// }
