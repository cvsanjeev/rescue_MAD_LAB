import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'agency.dart';

class AgencyDAO {
  static const String _tableName = 'agencies';

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'your_database_name.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT , address TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertAgency(agency agency) async {
    final db = await _getDatabase();
    await db.insert(
      _tableName,
      agency.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<agency>> getAllAgencies() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return agency(
        id: maps[i]['id'],
        name: maps[i]['name'],
        address: maps[i]['address'],
      );
    });
  }
  Future<agency?> getAgencyById(int id) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return agency(
        id: maps[0]['id'],
        name: maps[0]['name'],
        address: maps[0]['address'],
      );
    } else {
      return null;
    }
  }

// ... You might want additional functions like:
// ... Future<void> updateAgency(Agency agency)
// ... Future<void> deleteAgency(int id)
}
