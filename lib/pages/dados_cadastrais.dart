import 'package:flutter/material.dart';

class DadosCadastrais extends StatelessWidget {
  final String titulo;
  final List<String> dados;
  const DadosCadastrais({super.key, required this.titulo, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Center(child: Text(dados.length.toString())),
    );
  }
}
