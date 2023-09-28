import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa.dart';
import 'package:trilhaapp/repository/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var descController = TextEditingController();
  var _tarefas = <Tarefa>[];
  var apenasNaoconcluido = false;

  @override
  void initState() {
    obterTarefas();
    super.initState();
  }

  void obterTarefas() async {
    _tarefas = apenasNaoconcluido
        ? await tarefaRepository.listarNaoConcluidas()
        : await tarefaRepository.listar();
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
                    key: Key(tarefa.id),
                    onDismissed: (direction) async {
                      await tarefaRepository.remove(tarefa.id);
                      obterTarefas();
                    },
                    child: ListTile(
                      title: Text(tarefa.desc),
                      trailing: Switch(
                        value: tarefa.concluido,
                        onChanged: (value) async {
                          await tarefaRepository.alterar(tarefa.id, value);
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
                      await tarefaRepository
                          .adicionar(Tarefa(descController.text, false));
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      setState(() {});
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
