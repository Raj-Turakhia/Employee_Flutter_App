import 'package:employee_app/services/database/models/employee.dart';
import 'package:employee_app/services/database/persistence_layer.dart';
import 'package:employee_app/services/database/providers/table_provider.dart';

class EmployeeRepository extends TableProvider {
  @override
  String get tableName => 'Employee';

  EmployeeRepository._();

  static final EmployeeRepository db = EmployeeRepository._();

  @override
  String getCreateTableSql() {
    return '''
    CREATE TABLE $tableName (
    ${Employee.IdField} INTEGER PRIMARY KEY autoincrement,
    ${Employee.NameField} TEXT,
    ${Employee.RoleField} TEXT,
    ${Employee.StartDateField} TEXT,
    ${Employee.EndDateField} TEXT
    );
    ''';
  }

  Future<int> addEmployee(Employee employee) async {
    final db = await PersistenceLayer().database;
    return await db?.insert(tableName, employee.toMap()) ?? -1;
  }

  Future<List<Employee>> fetchEmployees() async {
    final db = await PersistenceLayer().database;
    List<Map<String, dynamic>> maps = await db?.query(tableName) ?? [];
    return maps.map((e) => Employee.fromMap(e)).toList();
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await PersistenceLayer().database;
    return await db?.update(tableName, employee.toMap(),
        where: '${Employee.IdField}=${employee.id}') ?? -1;
  }

  Future<int> deleteEmployee(Employee employee) async {
    final db = await PersistenceLayer().database;
    return await db?.delete(tableName, where: '${Employee.IdField} == ?',
      whereArgs: [employee.id],) ?? -1;
  }
}
