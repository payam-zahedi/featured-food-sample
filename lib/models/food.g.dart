// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodList _$FoodListFromJson(Map<String, dynamic> json) {
  return FoodList(
      foods: (json['foods'] as List)
          .map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$FoodListToJson(FoodList instance) =>
    <String, dynamic>{'foods': instance.foods};

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
      image: json['image'] as String,
      background: json['background'],
      foreground: json['foreground'],
      name: json['name'] as String,
      starRating: (json['starRating'] as num).toDouble(),
      desc: json['desc'] as String,
      price: (json['price'] as num).toDouble(),
      foodType: _$enumDecode(_$FoodTypeEnumMap, json['foodType']));
}

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'image': instance.image,
      'background': instance.background,
      'foreground': instance.foreground,
      'name': instance.name,
      'starRating': instance.starRating,
      'desc': instance.desc,
      'price': instance.price,
      'foodType': _$FoodTypeEnumMap[instance.foodType]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$FoodTypeEnumMap = <FoodType, dynamic>{
  FoodType.Pizza: 'Pizza',
  FoodType.Rolls: 'Rolls',
  FoodType.Burgers: 'Burgers',
  FoodType.Sandwiches: 'Sandwiches'
};
