import 'package:hive/hive.dart';

class HiveService {
  // Method to initialize Hive (open the box)
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  // Method to get all values from a box
  Future<List<T>> getAllValues<T>(String boxName) async {
    var box = await openBox<T>(boxName);
    return box.values.toList();
  }

  // Method to get a specific value by key from a box
  Future<T?> getValue<T>(String boxName, dynamic key) async {
    var box = await openBox<T>(boxName);
    return box.get(key);
  }

  // Method to add a new value to the box
  Future<void> addValue<T>(String boxName, dynamic key, T value) async {
    var box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  // Method to update an existing value in the box
  Future<void> updateValue<T>(String boxName, dynamic key, T newValue) async {
    var box = await openBox<T>(boxName);
    if (box.containsKey(key)) {
      await box.put(key, newValue);
    }
  }

  // Method to delete a value from the box
  Future<void> deleteValue<T>(String boxName, dynamic key) async {
    var box = await openBox<T>(boxName);
    if (box.containsKey(key)) {
      await box.delete(key);
    }
  }

  // Method to close the box
  Future<void> closeBox(String boxName) async {
    var box = await Hive.openBox(boxName);
    await box.close();
  }

  // Method to delete the entire box
  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
