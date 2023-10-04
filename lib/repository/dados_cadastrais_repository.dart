import 'package:hive/hive.dart';

import '../model/dados_cadastrais.dart';

class DadosCadastraisRepository {
  static late Box _box;

  DadosCadastraisRepository._load();

  static Future<DadosCadastraisRepository> load() async {
    if (Hive.isBoxOpen('dadosCadastrais')) {
      _box = Hive.box('dadosCadastrais');
    } else {
      _box = await Hive.openBox('dadosCadastrais');
    }
    return DadosCadastraisRepository._load();
  }

  void salvar(DadosCadastrais dadosCadastrais) {
    _box.put('dadosCadastrais', dadosCadastrais);
  }

  DadosCadastrais obterDados() {
    var dadosCadastrais= _box.get('dadosCadastrais');
    if (dadosCadastrais == null) {
      return DadosCadastrais.vazio();
    }
    return dadosCadastrais;
  }
}
