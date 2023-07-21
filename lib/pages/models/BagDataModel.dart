import 'package:hive/hive.dart';
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
  });
}
