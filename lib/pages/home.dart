import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trilhaapp/service/gerador_numero_aleatorio_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var numeroGerado = 0;
  var quantidadeClique = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Meu app",
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.yellow,
              child: const Text(
                "Ações do usuário",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.brown,
              child: Text(
                "Foi clicado $quantidadeClique vezes",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.purple,
              child: Text(
                "O número gerado foi $numeroGerado",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.red,
                        child: const Text("10", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.blue,
                        child: const Text("20", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.green,
                        child: const Text("30", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            numeroGerado = GeradorNumeroAleatorioService.gerarNumeroAleatorio();
            quantidadeClique = quantidadeClique + 1;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
