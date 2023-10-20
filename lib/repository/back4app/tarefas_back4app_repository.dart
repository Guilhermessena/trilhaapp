import 'package:trilhaapp/model/tarefas_back4app.dart';
import 'package:trilhaapp/repository/back4app/back4app_custom_dio.dart';

class TarefasBack4appRepository {
  final _customDio = Back4appCustomDio();

  TarefasBack4appRepository();
  
  Future<TarefasBack4app> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";
    if (naoConcluidas) {
      url = '$url?where={"concluido":true}';
    }
    var result = await _customDio.dio.get(url);
    return TarefasBack4app.fromJson(result.data);
  }

  Future<void> salvarTarefa(TarefaBack4app tarefa) async {
    try {
      await _customDio.dio.post("/Tarefas", data: tarefa.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizarTarefa(TarefaBack4app tarefa) async {
    try {
      await _customDio.dio.put("/Tarefas/${tarefa.objectId}",
          data: tarefa.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removerTarefa(String objectId) async {
    try {
      await _customDio.dio.delete("/Tarefas/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
