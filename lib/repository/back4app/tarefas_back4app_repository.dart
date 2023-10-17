import 'package:dio/dio.dart';
import 'package:trilhaapp/model/tarefas_back4app.dart';

class TarefasBack4appRepository {
  final _dio = Dio();

  TarefasBack4appRepository() {
    _dio.options.headers['X-Parse-Application-Id'] =
        'lypw0cOApyi9tQ6lNNPxjtAeAwsPVUO7nbhXtruQ';
    _dio.options.headers['X-Parse-REST-API-Key'] =
        'fXsDeZkJx8ySK0C6qO8knu4c495cRPRUqMVahGm0';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }
  Future<TarefasBack4app> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";
    if (naoConcluidas) {
      url = '$url?where={"concluido":true}';
    }
    var result = await _dio.get(url);
    return TarefasBack4app.fromJson(result.data);
  }

  Future<void> salvarTarefa(TarefaBack4app tarefa) async {
    try {
      await _dio.post("/Tarefas", data: tarefa.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizarTarefa(TarefaBack4app tarefa) async {
    try {
      await _dio.put("/Tarefas/${tarefa.objectId}",
          data: tarefa.toCreateJson());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removerTarefa(String objectId) async {
    try {
      await _dio.delete("/Tarefas/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
