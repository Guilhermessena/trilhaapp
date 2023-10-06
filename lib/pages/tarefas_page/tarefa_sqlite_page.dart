import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_sqlite.dart';
import 'package:trilhaapp/repository/sqlite/tarefa_sqlite_repository.dart';

class TarefaSqlitePage extends StatefulWidget {
  const TarefaSqlitePage({super.key});

  @override
  State<TarefaSqlitePage> createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  var tarefaSqliteRepository = TarefaSqliteRepository();
  var descController = TextEditingController();
  var _tarefas = <TarefaSqlite>[];
  var apenasNaoconcluido = false;

  @override
  void initState() {
    obterTarefas();
    super.initState();
  }

  void obterTarefas() async {
    _tarefas = await tarefaSqliteRepository.obterDados(apenasNaoconcluido);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tarefas não concluidas",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: apenasNaoconcluido,
                    onChanged: (value) {
                      apenasNaoconcluido = value;
                      obterTarefas();
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (context, index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    key: Key(tarefa.descricao),
                    onDismissed: (direction) async {
                      tarefaSqliteRepository.delete(tarefa.id);
                      obterTarefas();
                    },
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        value: tarefa.concluido,
                        onChanged: (value) async {
                          tarefa.concluido = value;
                          tarefaSqliteRepository.update(tarefa);
                          obterTarefas();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descController.text = '';

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(
                  controller: descController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await tarefaSqliteRepository
                          .save(TarefaSqlite(0, descController.text, false));
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      obterTarefas();
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
