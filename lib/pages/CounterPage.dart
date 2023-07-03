import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_outlined)),
        title: const SizedBox(width: 190),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.format_paint_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
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
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 8.5,
          ),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: const Color(0xFF69B7FF)),
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
                    color: const Color(0xFF69B7FF),
                    width: 48,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                      size: 24.0,
                    ),
                  ),
                ),
                Text(
                  '${entry.value}',
                  style: const TextStyle(fontSize: 22.0),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      clothes[entry.key] =
                          entry.value + 1; //update that entry in the map.
                    });
                  },
                  child: Container(
                    color: const Color(0xFF69B7FF),
                    width: 48.0,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      size: 24.0,
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
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
      child: Row(
        children: [
          const Text(
            "TOTAL:",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
}
