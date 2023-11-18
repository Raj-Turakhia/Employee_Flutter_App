import 'package:employee_app/services/database/repository/employee_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersistenceLayer {
  static const DatabaseName = 'employee_db';

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _getDatabaseInstance();
    return _database;
  }

  Future<Database> _getDatabaseInstance() async {
    final path = join(await getDatabasesPath(), '$DatabaseName.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        final sqlStatements = [
          EmployeeRepository.db.getCreateTableSql(),
        ];

        sqlStatements.forEach((stmt) async {
          await db.execute(stmt).catchError((error) => print(
                error.toString(),
              ));
        });
      },
    );
  }
}
