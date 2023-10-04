import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({super.key});

  @override
  State<ConfiguracoesSharedPreferencesPage> createState() => _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState extends State<ConfiguracoesSharedPreferencesPage> {
  var alturaController = TextEditingController();
  var nomeUsuarioController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberPushNotification = false;
  bool temaEscuro = false;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text = (await storage.getConfiguracoesAltura()).toString();
    receberPushNotification =
        await storage.getConfiguracoesReceberPushNotification();
    temaEscuro = await storage.getConfiguracoesTemaEscuro();
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
                  await storage.setConfiguracoesAltura(
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
                await storage
                    .setConfiguracoesNomeUsuario(nomeUsuarioController.text);
                await storage.setConfiguracoesReceberPushNotification(
                    receberPushNotification);
                await storage.setConfiguracoesTemaEscuro(temaEscuro);
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
