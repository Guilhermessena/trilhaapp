import 'package:flutter/material.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/niveis_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nomeController = TextEditingController(text: '');
  var dtNascController = TextEditingController(text: '');
  var niveisRepository = NiveisRepository();
  var linguagensRepository = LinguagensRepository();
  DateTime? dtNasc;
  var niveisExp = [];
  var linguagens = [];
  var linguagensSelecionada = [];
  var nivelSelecionado = "";
  var pretensaoSalarial = 0.0;
  var tempoExp = 0;
  var isValidating = false;

  @override
  void initState() {
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
                    onPressed: () {
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
