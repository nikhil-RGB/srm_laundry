import 'package:hive/hive.dart';
import 'package:laundry_counter/pages/CounterPage.dart';
part 'BagDataModel.g.dart';

@HiveType(typeId: 0)
class BagDataModel extends HiveObject {
  @HiveField(0)
  int pants;
  @HiveField(1)
  int shirts;
  @HiveField(2)
  int tshirts;
  @HiveField(3)
  int shorts;
  @HiveField(4)
  int towels;
  @HiveField(5)
  int pillows;
  @HiveField(6)
  int bedsheets;
  @HiveField(7)
  int others;
  @HiveField(8)
  int total;
  @HiveField(9)
  String date;
  @HiveField(10)
  int bagNo;

  BagDataModel({
    this.pants = 0,
    this.shirts = 0,
    this.tshirts = 0,
    this.shorts = 0,
    this.towels = 0,
    this.pillows = 0,
    this.bedsheets = 0,
    this.others = 0,
    this.total = 0,
    this.date = "",
    this.bagNo = 0,
  }) {
    if (date.isEmpty) {
      date = currentDate();
    }
  }
}
