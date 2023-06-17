import 'package:flutter/material.dart';

import 'Counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
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
        children: const [
          SizedBox(
            height: 10,
          ),
          Counter(
            title: "Pants/Bottoms",
          ),
          Counter(title: "Shirts/Tops"),
          Counter(title: "T-Shirts"),
          Counter(title: "Half-Pants/Shorts"),
          Counter(title: "Towels"),
          Counter(title: "Pillow Covers"),
          Counter(title: "Bedsheets"),
          Counter(title: "Others"),
        ],
      ),
    );
  }
}
