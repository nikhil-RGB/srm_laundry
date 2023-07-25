import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:laundry_counter/pages/models/BagDataModel.dart';

class HiveObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      // App is being paused or closed, close Hive boxes
      await Hive.close();
    } else if (state == AppLifecycleState.resumed) {
      // App is being resumed, reopen Hive boxes

      await Hive.openBox<BagDataModel>("laundry_log");
      await Hive.openBox("darkMode");
    }
  }
}
