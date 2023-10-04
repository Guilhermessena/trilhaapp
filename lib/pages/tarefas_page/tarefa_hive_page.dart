import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive.dart';
import 'package:trilhaapp/repository/tarefa_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefaHiveRepository tarefaHiveRepository;
  var descController = TextEditingController();
  var _tarefas = <TarefaHive>[];
  var apenasNaoconcluido = false;

  @override
  void initState() {
    obterTarefas();
    super.initState();
  }

  void obterTarefas() async {
    tarefaHiveRepository = await TarefaHiveRepository.load();
    _tarefas = tarefaHiveRepository.obterDados(apenasNaoconcluido);
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
                      tarefaHiveRepository.remove(tarefa);
                      obterTarefas();
                    },
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        value: tarefa.concluido,
                        onChanged: (value) async {
                          tarefa.concluido = value;
                          tarefaHiveRepository.alterar(tarefa);
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
                      await tarefaHiveRepository
                          .salvar(TarefaHive.criar(descController.text, false));
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
