import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int numeroGerado = 0;
  int quantidadeCliques = 0;

  AppStorageService prefs = AppStorageService();

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    numeroGerado = await prefs.getNumerosAleatoriosNumeroAleatorio();
    quantidadeCliques =
        await prefs.getNumerosAleatoriosAleatoriosQuantidadeCliques();
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
            // final prefs = await SharedPreferences.getInstance();
            // await prefs.remove(CHAVE_NUMERO_ALEATORIO);
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(100);
              quantidadeCliques = (quantidadeCliques) + 1;
            });
            await prefs.setNumerosAleatoriosNumeroAleatorio(numeroGerado);
            await prefs
                .setNumerosAleatoriosQuantidadeCliques(quantidadeCliques);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
