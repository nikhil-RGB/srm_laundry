import 'package:hive/hive.dart';

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
}
