import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final String title;
  const Counter({super.key, required this.title});
  @override
  // ignore: library_private_types_in_public_api
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
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
                  onTap: _decrementCounter,
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
                  '$_counter',
                  style: const TextStyle(fontSize: 22.0),
                ),
                InkWell(
                  onTap: _incrementCounter,
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
}
