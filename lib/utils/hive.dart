import 'package:hive/hive.dart';

class AppUtils {
  static Future<String> welcomeMessage(String profileName) async {
    final box = await Hive.openBox('Users');
    if (box.containsKey(profileName)) {
      return "Glad to see you again !";
    }
    box.put(profileName, "");
    return "Welcome !";
  }

  static Future<void> setFavoriteSparklingWater(
      String profileName, String favoriteSparklingWater) async {
    final box = await Hive.openBox('Users');
    box.put(profileName, favoriteSparklingWater);
  }

  static Future<String> getFavoriteSparklingWater(String profileName) async {
    final box = await Hive.openBox('Users');
    print(box.get(profileName));
    return box.get(profileName);
  }
}
