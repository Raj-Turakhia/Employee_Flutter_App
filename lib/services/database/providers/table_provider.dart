import '../persistence_layer.dart';

abstract class TableProvider {
  String get tableName;

  String getCreateTableSql();

  Future<void> get deleteTable async {
    final db = (await PersistenceLayer().database)!;
    await db.delete(tableName);
  }
}
