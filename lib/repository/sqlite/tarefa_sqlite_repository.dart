import 'package:trilhaapp/model/tarefa_sqlite.dart';
import 'package:trilhaapp/repository/sqlite/database.dart';

class TarefaSqliteRepository {
  Future<List<TarefaSqlite>> obterDados(bool apenasNaoconcluido) async {
    List<TarefaSqlite> tarefas = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
      apenasNaoconcluido ? 'SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0':
      'SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(TarefaSqlite(
        int.parse(element['id'].toString()),
        element['descricao'].toString(),
        element['concluido'] == 1,
      ));
    }
    return tarefas;
  }

  Future<void> save(TarefaSqlite tarefaSqlite) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert(
      'INSERT INTO tarefas (descricao, concluido) values (?, ?)',
      [tarefaSqlite.descricao, tarefaSqlite.concluido],
    );
  }

  Future<void> update(TarefaSqlite tarefaSqlite) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert(
      'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?',
      [
        tarefaSqlite.descricao,
        tarefaSqlite.concluido ? 1 : 0,
        tarefaSqlite.id,
      ],
    );
  }

  Future<void> delete(int id) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert(
      'DELETE FROM tarefas WHERE id = ?',
      [id],
    );
  }
}
