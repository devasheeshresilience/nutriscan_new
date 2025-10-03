// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodItemModelAdapter extends TypeAdapter<FoodItemModel> {
  @override
  final int typeId = 0;

  @override
  FoodItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodItemModel(
      name: fields[0] as String,
      calories: fields[1] as double,
      fats: fields[2] as double,
      proteins: fields[3] as double,
      carbs: fields[4] as double,
      sugar: fields[5] as double,
      fiber: fields[6] as double,
      sodium: fields[7] as double,
      date: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FoodItemModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.calories)
      ..writeByte(2)
      ..write(obj.fats)
      ..writeByte(3)
      ..write(obj.proteins)
      ..writeByte(4)
      ..write(obj.carbs)
      ..writeByte(5)
      ..write(obj.sugar)
      ..writeByte(6)
      ..write(obj.fiber)
      ..writeByte(7)
      ..write(obj.sodium)
      ..writeByte(8)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
