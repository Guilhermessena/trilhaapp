import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefas_back4app.dart';
import 'package:trilhaapp/repository/back4app/tarefas_back4app_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TarefasBack4appRepository tarefaRepository = TarefasBack4appRepository();
  var descController = TextEditingController();
  var _tarefasBack4app = TarefasBack4app([]);
  var apenasNaoconcluido = false;
  var carregando = false;

  @override
  void initState() {
    obterTarefas();
    super.initState();
  }

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefasBack4app = await tarefaRepository.obterTarefas(apenasNaoconcluido);
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas HTTP'),
      ),
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
            carregando
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tarefasBack4app.tarefa.length,
                      itemBuilder: (context, index) {
                        var tarefa = _tarefasBack4app.tarefa[index];
                        return Dismissible(
                          key: Key(tarefa.dsDescricao ?? ''),
                          onDismissed: (direction) async {
                            await tarefaRepository
                                .removerTarefa(tarefa.objectId ?? '');
                            obterTarefas();
                          },
                          child: ListTile(
                            title: Text(tarefa.dsDescricao ?? ''),
                            trailing: Switch(
                              value: tarefa.concluido ?? false,
                              onChanged: (value) async {
                                tarefa.concluido = value;
                                await tarefaRepository.atualizarTarefa(tarefa);
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
                      await tarefaRepository.salvarTarefa(
                          TarefaBack4app.create(descController.text, false));
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
