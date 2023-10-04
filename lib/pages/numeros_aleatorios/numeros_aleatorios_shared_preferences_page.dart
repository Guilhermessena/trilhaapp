import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() => _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState extends State<NumerosAleatoriosSharedPreferencesPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;

  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumerosAleatoriosNumeroAleatorio();
    quantidadeCliques =
        await storage.getNumerosAleatoriosAleatoriosQuantidadeCliques();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de números aleatorios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado.toString(),
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                quantidadeCliques.toString(),
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // final storage = await SharedPreferences.getInstance();
            // await storage.remove(CHAVE_NUMERO_ALEATORIO);
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(100);
              quantidadeCliques = (quantidadeCliques) + 1;
            });
            await storage.setNumerosAleatoriosNumeroAleatorio(numeroGerado);
            await storage
                .setNumerosAleatoriosQuantidadeCliques(quantidadeCliques);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
