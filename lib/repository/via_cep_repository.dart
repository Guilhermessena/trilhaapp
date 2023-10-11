import 'dart:convert';

import 'package:trilhaapp/model/via_cep.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCep> consultarCep(String cep) async {
    var response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      var jsonCep = jsonDecode(response.body);
      return ViaCep.fromJson(jsonCep);
    }
    return ViaCep();
  }
}
