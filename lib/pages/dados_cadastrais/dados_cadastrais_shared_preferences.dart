import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/niveis_repository.dart';
import 'package:trilhaapp/services/app_storage_service.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisSharedPreferences extends StatefulWidget {
  const DadosCadastraisSharedPreferences({super.key});

  @override
  State<DadosCadastraisSharedPreferences> createState() => _DadosCadastraisSharedPreferencesState();
}

class _DadosCadastraisSharedPreferencesState extends State<DadosCadastraisSharedPreferences> {
  var nomeController = TextEditingController(text: '');
  var dtNascController = TextEditingController(text: '');
  var niveisRepository = NiveisRepository();
  var linguagensRepository = LinguagensRepository();
  DateTime? dtNasc;
  var niveisExp = [];
  var linguagens = [];
  List<String> linguagensSelecionada = [];
  var nivelSelecionado = "";
  var pretensaoSalarial = 0.0;
  var tempoExp = 0;
  var isValidating = false;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    carregarDados();
    niveisExp = niveisRepository.listNiveis();
    linguagens = linguagensRepository.listLinguagens();
    super.initState();
  }

  List<DropdownMenuItem<int>> listTileDropDown(int qtd) {
    var items = <DropdownMenuItem<int>>[];
    for (var i = 0; i < qtd; i++) {
      items.add(DropdownMenuItem(
        value: i,
        child: Text(i.toString()),
      ));
    }
    return items;
  }

  void carregarDados() async {
    nomeController.text = await storage.getDadosCadastraisNome();
    dtNascController.text = await storage.getDadosCadastraisDtNasc();
    if (dtNascController.text.isNotEmpty) {
      dtNasc = DateTime.parse(dtNascController.text);
    }
    nivelSelecionado = await storage.getDadosCadastraisNivelExp();
    linguagensSelecionada = await storage.getDadosCadastraisLinguagem();
    tempoExp = await storage.getDadosCadastraisTempoExp();
    pretensaoSalarial = await storage.getDadosCadastraisPretensaoSalarial();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: isValidating
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: ListView(
                children: [
                  const TextLabel(
                    texto: "Nome",
                  ),
                  TextField(
                    controller: nomeController,
                  ),
                  const TextLabel(
                    texto: "Data de nascimento",
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000, 09, 15),
                        firstDate: DateTime(1900, 01, 01),
                        lastDate: DateTime(2023, 09, 26),
                      );
                      if (data != null) {
                        dtNascController.text = data.toString();
                        dtNasc = data;
                      }
                    },
                    controller: dtNascController,
                  ),
                  const TextLabel(
                    texto: "Nivel",
                  ),
                  Column(
                    children: niveisExp
                        .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              selected: nivelSelecionado == nivel,
                              onChanged: (value) {
                                setState(() {
                                  nivelSelecionado = nivel.toString();
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(
                    texto: "Linguagens Favoritas",
                  ),
                  Column(
                    children: linguagens
                        .map((linguagem) => CheckboxListTile(
                              dense: true,
                              title: Text(linguagem.toString()),
                              value: linguagensSelecionada.contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    linguagensSelecionada.add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    linguagensSelecionada.remove(linguagem);
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(
                    texto: "Tempo de experiência",
                  ),
                  DropdownButton(
                    isExpanded: true,
                    items: listTileDropDown(50),
                    value: tempoExp,
                    onChanged: (int? value) {
                      setState(() {
                        tempoExp = value!;
                      });
                    },
                  ),
                  TextLabel(
                    texto:
                        "Pretensão salarial. R\$ ${pretensaoSalarial.toStringAsFixed(2).toString().replaceAll(".", ",")}",
                  ),
                  Slider(
                    value: pretensaoSalarial,
                    min: 0,
                    max: 10000,
                    onChanged: (value) {
                      setState(() {
                        pretensaoSalarial = value;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (nomeController.text.length <= 3) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Nome inválido, digite mais de 3 caracteres")));
                        return;
                      }
                      if (dtNascController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Insira a data")));
                        return;
                      }
                      if (nivelSelecionado == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Selecione um nivel")));
                        return;
                      }
                      if (linguagensSelecionada.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Escolha pelo menos uma linguagem")));
                        return;
                      }
                      if (tempoExp == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Selecione um valor maior que 0")));
                        return;
                      }
                      if (pretensaoSalarial == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Selecione um salario maior que 0")));
                        return;
                      }

                      await storage.setDadosCadastraisNome(nomeController.text);
                      await storage.setDadosCadastraisDtNasc(dtNasc!);
                      await storage.setDadosCadastraisNivelExp(nivelSelecionado);
                      await storage
                          .setDadosCadastraisLinguagem(linguagensSelecionada);
                      await storage.setDadosCadastraisTempoExp(tempoExp);
                      await storage.setDadosCadastraisPretensaoSalarial(
                          pretensaoSalarial);

                      setState(() {
                        isValidating = !isValidating;
                      });
                      Future.delayed(
                        const Duration(seconds: 3),
                        () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Salvo com sucesso!"),
                            ),
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Text("Salvar"),
                  )
                ],
              )),
    );
  }
}
