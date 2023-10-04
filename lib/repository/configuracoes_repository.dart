import 'package:hive/hive.dart';
import 'package:trilhaapp/model/configuracoes.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._load();

  static Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen('configuracoes')) {
      _box = Hive.box('configuracoes');
    } else {
      _box = await Hive.openBox('configuracoes');
    }
    return ConfiguracoesRepository._load();
  }

  void salvar(Configuracoes configuracoes) {
    _box.put('configuracoes', {
      'nomeUsuario': configuracoes.nomeUsuario,
      'altura': configuracoes.altura,
      'receberPushNotification': configuracoes.receberPushNotification,
      'temaEscuro': configuracoes.temaEscuro,
    });
  }

  Configuracoes obterDados() {
    var configuracoes = _box.get('configuracoes');
    if (configuracoes == null) {
      return Configuracoes.vazio();
    }
    return Configuracoes(
      configuracoes['nomeUsuario'],
      configuracoes['altura'],
      configuracoes['receberPushNotification'],
      configuracoes['temaEscuro'],
    );
  }
}
