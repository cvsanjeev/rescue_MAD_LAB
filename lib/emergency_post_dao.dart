import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // For database path management
import 'emergency_post.dart';

class EmergencyPostDAO {
  static const String _tableName = 'emergency_posts';

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'emergency_posts.db'), // Database path
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id TEXT PRIMARY KEY, type TEXT, location TEXT, timestamp TEXT, status TEXT, additional_details TEXT, issuing_agent_id TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertPost(EmergencyPost post) async {
    final db = await _getDatabase();
    await db.insert(_tableName, post.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<EmergencyPost>> getAllPosts() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return EmergencyPost.fromMap(maps[i]);
    });
  }
// ... add more methods for update, delete, etc.
}
