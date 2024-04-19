import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'agent.dart';

class AgentDAO {
  static const String _tableName = 'agents';

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'agent_list.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT, mobileNumber TEXT, status TEXT, agencyId INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertAgent(Agent agent) async {
    final db = await _getDatabase();
    await db.insert(
      _tableName,
      agent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Agent>> getAllAgents() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Agent(
        id: maps[i]['id'],
        name: maps[i]['name'],
        mobileNumber: maps[i]['mobileNumber'],
        status: maps[i]['status'],
        agencyId: maps[i]['agencyId'],
      );
    });
  }

  Future<void> updateAgent(Agent agent) async {
    final db = await _getDatabase();
    await db.update(
      _tableName,
      agent.toMap(),
      where: 'id = ?',
      whereArgs: [agent.id],
    );
  }

  Future<void> deleteAgent(Agent agent) async {
    final db = await _getDatabase();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [agent.id],
    );
  }
  Future<List<Agent>> getAgentsByAgencyId(int agencyId) async {
    final db = await _getDatabase();

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'agencyId = ?',
        whereArgs: [agencyId],
      );

      return List.generate(maps.length, (i) {
        print('DEBUG: Data for Agent $i: ${maps[i]}');
        return Agent(

          id: maps[i]['id'],
          name: maps[i]['name'],
          mobileNumber: maps[i]['mobileNumber'],
          status: maps[i]['status'],
          agencyId: maps[i]['agencyId'],
        );
      });

    } catch(error) {
      print('Error fetching agents by agency ID: $error');
      return []; // Return an empty list on error
    }
  }

  Future<List<Agent>?> getAgentById(int enteredAgentId) async {
    final db = await _getDatabase();

    try {
      final List<Map<String, dynamic>> maps = await db.query(
        _tableName,
        where: 'mobileNumber = ?',
        whereArgs: [enteredAgentId],
      );

      return List.generate(maps.length, (i) {
        print('DEBUG: Data for Agent $i: ${maps[i]}');
        return Agent(

          id: maps[0]['id'],
          name: maps[0]['name'],
          mobileNumber: maps[0]['mobileNumber'],
          status: maps[0]['status'],
          agencyId: maps[0]['agencyId'],
        );
      });

    } catch(error) {
      print('Error fetching agents by agent ID: $error');
      return []; // Return an empty list on error
    }
  }


}
