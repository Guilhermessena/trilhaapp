import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa_hive.dart';

class TarefaHiveRepository {
  static late Box _box;

  TarefaHiveRepository._load();

  static Future<TarefaHiveRepository> load() async {
    if (Hive.isBoxOpen('tarefaHive')) {
      _box = Hive.box('tarefaHive');
    } else {
      _box = await Hive.openBox('tarefaHive');
    }
    return TarefaHiveRepository._load();
  }

  salvar(TarefaHive tarefaHive) {
    _box.add(tarefaHive);
  }

  alterar(TarefaHive tarefaHive) {
    tarefaHive.save();
  }

  remove(TarefaHive tarefaHive) {
    tarefaHive.delete();
  }

  List<TarefaHive> obterDados(bool naoConcluido) {
    if (naoConcluido) {
      return _box.values
          .cast<TarefaHive>()
          .where((element) => !element.concluido)
          .toList();
    }
    return _box.values.cast<TarefaHive>().toList();
  }
}
