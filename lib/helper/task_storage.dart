import 'package:shared_preferences/shared_preferences.dart';

class TaskStorage {
  // Save tasks
  static Future<void> saveTasks(List<String> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  // Load tasks
  static Future<List<String>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('tasks') ?? [];
  }
}
