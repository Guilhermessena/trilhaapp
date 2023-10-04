import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais.dart';
import 'package:trilhaapp/repository/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repository/linguagens_repository.dart';
import 'package:trilhaapp/repository/niveis_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHive extends StatefulWidget {
  const DadosCadastraisHive({super.key});

  @override
  State<DadosCadastraisHive> createState() => _DadosCadastraisHiveState();
}

class _DadosCadastraisHiveState extends State<DadosCadastraisHive> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastrais = DadosCadastrais.vazio();

  var nomeController = TextEditingController(text: '');
  var dtNascController = TextEditingController(text: '');
  var niveisRepository = NiveisRepository();
  var linguagensRepository = LinguagensRepository();
  var niveisExp = [];
  var linguagens = [];
  var isValidating = false;

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
    dadosCadastraisRepository = await DadosCadastraisRepository.load();
    dadosCadastrais = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastrais.nome ?? '';
    dtNascController.text =
        dadosCadastrais.dtNasc == null ? '' : dadosCadastrais.dtNasc.toString();
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
                        dadosCadastrais.dtNasc = data;
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
                              groupValue: dadosCadastrais.nivelExp,
                              selected: dadosCadastrais.nivelExp == nivel,
                              onChanged: (value) {
                                setState(() {
                                  dadosCadastrais.nivelExp = value.toString();
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
                              value: dadosCadastrais.linguagens
                                  .contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    dadosCadastrais.linguagens.add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    dadosCadastrais.linguagens
                                        .remove(linguagem);
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
                    value: dadosCadastrais.tempoExp,
                    onChanged: (int? value) {
                      setState(() {
                        dadosCadastrais.tempoExp = value!;
                      });
                    },
                  ),
                  TextLabel(
                    texto:
                        "Pretensão salarial. R\$ ${dadosCadastrais.pretensaoSalarial?.toStringAsFixed(2).toString().replaceAll(".", ",")}",
                  ),
                  Slider(
                    value: dadosCadastrais.pretensaoSalarial ?? 0,
                    min: 0,
                    max: 10000,
                    onChanged: (value) {
                      setState(() {
                        dadosCadastrais.pretensaoSalarial = value;
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
                      if (dadosCadastrais.dtNasc == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Insira a data")));
                        return;
                      }
                      if (dadosCadastrais.nivelExp == null ||
                          dadosCadastrais.nivelExp?.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Selecione um nivel")));
                        return;
                      }
                      if (dadosCadastrais.linguagens.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Escolha pelo menos uma linguagem")));
                        return;
                      }
                      if (dadosCadastrais.tempoExp == 0 ||
                          dadosCadastrais.tempoExp == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Selecione um valor maior que 0")));
                        return;
                      }
                      if (dadosCadastrais.pretensaoSalarial == 0 ||
                          dadosCadastrais.pretensaoSalarial == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Selecione um salario maior que 0")));
                        return;
                      }
                      dadosCadastrais.nome = nomeController.text;
                      dadosCadastraisRepository.salvar(dadosCadastrais);

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
