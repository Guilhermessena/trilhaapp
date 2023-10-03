import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  var alturaController = TextEditingController();
  var nomeUsuarioController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;
  AppStorageService prefs = AppStorageService();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await prefs.getConfiguracoesNomeUsuario();
    alturaController.text = (await prefs.getConfiguracoesAltura()).toString();
    receberPushNotification =
        await prefs.getConfiguracoesReceberPushNotification();
    temaEscuro = await prefs.getConfiguracoesTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Configurações"),
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
              value: receberPushNotification,
              onChanged: (value) {
                setState(() {
                  receberPushNotification = !receberPushNotification;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Escolher tema"),
              value: temaEscuro,
              onChanged: (value) {
                setState(() {
                  temaEscuro = value;
                });
              },
            ),
            TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  await prefs.setConfiguracoesAltura(
                      double.parse(alturaController.text));
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
                await prefs
                    .setConfiguracoesNomeUsuario(nomeUsuarioController.text);
                await prefs.setConfiguracoesReceberPushNotification(
                    receberPushNotification);
                await prefs.setConfiguracoesTemaEscuro(temaEscuro);
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
