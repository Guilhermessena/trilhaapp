import '../model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<List<Tarefa>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluidas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.concluido).toList();
  }

  Future<void> adicionar(Tarefa tarefa) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.where((element) => element.id == id).first.concluido = concluido;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.remove(_tarefas.where((element) => element.id == id).first);
  }
}
