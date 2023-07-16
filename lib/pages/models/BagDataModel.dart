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
  BagDataModel(
      {required this.pants,
      required this.shirts,
      required this.tshirts,
      required this.shorts,
      required this.towels,
      required this.pillows,
      required this.bedsheets,
      required this.others,
      required this.total});
}
