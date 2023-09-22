import 'package:flutter/material.dart';

import 'dados_cadastrais.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: const Text("Dados cadastrais")),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DadosCadastrais(
                      titulo: "Dados Cadastrais", dados: ["nome", "endereço"]),
                ));
          },
        ),
        const Divider(),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: const Text("Termos de uso e privacidade")),
          onTap: () {},
        ),
        const Divider(),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              child: const Text("Configurações")),
          onTap: () {},
        ),
      ],
    );
  }
}
