import 'package:uuid/uuid.dart';

import '../../../../common/value_objects.dart';

class CategoryModel extends Entity<CategoryId> {
  String name;
  int icon;
  int color;
  double amount = 0;

  CategoryModel({
    required CategoryId id,
    required this.name,
    required this.icon,
    required this.color,
    required this.amount,
  }) : super(id);

// ignore: use_setters_to_change_properties
  void updateName(String newName) => name = newName;
  // ignore: use_setters_to_change_properties
  void updateIcon(int newIcon) => icon = newIcon;
  // ignore: use_setters_to_change_properties
  void updateColor(int newColor) => color = newColor;
  // ignore: use_setters_to_change_properties
  void updateAmount(double newAmount) => amount = newAmount;
}

class CategoryId extends AlphanumericId {
  const CategoryId(String value) : super(value);

  CategoryId.auto() : this(const Uuid().v1());
}
