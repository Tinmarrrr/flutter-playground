import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Users extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String? favoriteSparklingWater;

  Users(this.name, this.favoriteSparklingWater);
}
