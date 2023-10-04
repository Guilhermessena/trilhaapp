import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes.dart';
import 'package:trilhaapp/repository/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  var alturaController = TextEditingController();
  var nomeUsuarioController = TextEditingController();

  late ConfiguracoesRepository configuracoesRepository;

  var configuracoes = Configuracoes.vazio();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoes = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoes.nomeUsuario;
    alturaController.text = configuracoes.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Configurações Hive"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nomeUsuarioController,
                decoration: const InputDecoration(hintText: "nome usuario"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: alturaController,
                decoration: const InputDecoration(
                  hintText: "altura",
                ),
              ),
            ),
            SwitchListTile(
              title: const Text("Receber notificações"),
              value: configuracoes.receberPushNotification,
              onChanged: (value) {
                setState(() {
                  configuracoes.receberPushNotification =
                      !configuracoes.receberPushNotification;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Escolher tema"),
              value: configuracoes.temaEscuro,
              onChanged: (value) {
                setState(() {
                  configuracoes.temaEscuro = value;
                });
              },
            ),
            TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  configuracoes.altura = double.parse(alturaController.text);
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Meu app"),
                        content: const Text("Favor informar uma altura valida"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                }
                configuracoes.nomeUsuario = nomeUsuarioController.text;
                configuracoesRepository.salvar(configuracoes);
                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            )
          ],
        ),
      ),
    );
  }
}
