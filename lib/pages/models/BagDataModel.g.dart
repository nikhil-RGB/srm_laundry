// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BagDataModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BagDataModelAdapter extends TypeAdapter<BagDataModel> {
  @override
  final int typeId = 0;

  @override
  BagDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BagDataModel(
      pants: fields[0] as int,
      shirts: fields[1] as int,
      tshirts: fields[2] as int,
      shorts: fields[3] as int,
      towels: fields[4] as int,
      pillows: fields[5] as int,
      bedsheets: fields[6] as int,
      others: fields[7] as int,
      total: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BagDataModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.pants)
      ..writeByte(1)
      ..write(obj.shirts)
      ..writeByte(2)
      ..write(obj.tshirts)
      ..writeByte(3)
      ..write(obj.shorts)
      ..writeByte(4)
      ..write(obj.towels)
      ..writeByte(5)
      ..write(obj.pillows)
      ..writeByte(6)
      ..write(obj.bedsheets)
      ..writeByte(7)
      ..write(obj.others)
      ..writeByte(8)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BagDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
