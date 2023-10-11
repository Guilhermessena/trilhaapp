import 'package:flutter/material.dart';
import 'package:trilhaapp/model/via_cep.dart';
import 'package:trilhaapp/repository/via_cep_repository.dart';

class ConsultaCepPage extends StatefulWidget {
  const ConsultaCepPage({super.key});

  @override
  State<ConsultaCepPage> createState() => _ConsultaCepPageState();
}

class _ConsultaCepPageState extends State<ConsultaCepPage> {
  var cepController = TextEditingController(text: '');
  bool loading = false;
  var viaCep = ViaCep();
  var viaCepRepository = ViaCepRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16,
        ),
        child: Column(
          children: [
            const Text(
              'Consulta de cep',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              onChanged: (value) async {
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viaCep = await viaCepRepository.consultarCep(cep);
                }
                setState(() {
                  loading = false;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              viaCep.logradouro ?? "",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              '${viaCep.localidade ?? ''} - ${viaCep.uf ?? ''}',
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            Visibility(
              visible: loading,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    ));
  }
}
