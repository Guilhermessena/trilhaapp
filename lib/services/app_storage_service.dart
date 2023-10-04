import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_DADOS_CADASTRAIS_NOME,
  CHAVE_DADOS_CADASTRAIS_DT_NASC,
  CHAVE_DADOS_CADASTRAIS_NIVEL_EXP,
  CHAVE_DADOS_CADASTRAIS_LINGUAGEM,
  CHAVE_DADOS_CADASTRAIS_TEMPO_EXP,
  CHAVE_DADOS_CADASTRAIS_SALARIO,
  CHAVE_CONFIGURACOES_NOME_USUARIO,
  CHAVE_CONFIGURACOES_ALTURA,
  CHAVE_CONFIGURACOES_RECEBER_PUSH_NOTIFICATION,
  CHAVE_CONFIGURACOES_TEMA_ESCURO,
  CHAVE_NUMERO_ALEATORIO,
  CHAVE_QUANTIDADE_CLIQUES
}

class AppStorageService {
  Future<void> setDadosCadastraisNome(String value) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(), value);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString());
  }

  Future<void> setDadosCadastraisDtNasc(DateTime value) async {
    await _setString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DT_NASC.toString(),
        value.toString());
  }

  Future<String> getDadosCadastraisDtNasc() async {
    return _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DT_NASC.toString());
  }

  Future<void> setDadosCadastraisNivelExp(String value) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXP.toString(), value);
  }

  Future<String> getDadosCadastraisNivelExp() async {
    return _getString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXP.toString());
  }

  Future<void> setDadosCadastraisLinguagem(List<String> value) async {
    await _setStringList(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGEM.toString(), value);
  }

  Future<List<String>> getDadosCadastraisLinguagem() async {
    return _getStringList(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGEM.toString());
  }

  Future<void> setDadosCadastraisTempoExp(int value) async {
    await _setInt(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXP.toString(), value);
  }

  Future<int> getDadosCadastraisTempoExp() async {
    return _getInt(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXP.toString());
  }

  Future<void> setDadosCadastraisPretensaoSalarial(double value) async {
    await _setDouble(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString(), value);
  }

  Future<double> getDadosCadastraisPretensaoSalarial() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString());
  }

  Future<void> setConfiguracoesNomeUsuario(String value) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_CONFIGURACOES_NOME_USUARIO.toString(), value);
  }

  Future<String> getConfiguracoesNomeUsuario() async {
    return _getString(
        STORAGE_CHAVES.CHAVE_CONFIGURACOES_NOME_USUARIO.toString());
  }

  Future<void> setConfiguracoesAltura(double value) async {
    await _setDouble(
        STORAGE_CHAVES.CHAVE_CONFIGURACOES_ALTURA.toString(), value);
  }

  Future<double> getConfiguracoesAltura() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_CONFIGURACOES_ALTURA.toString());
  }

  Future<void> setConfiguracoesReceberPushNotification(bool value) async {
    await _setBool(
        STORAGE_CHAVES.CHAVE_CONFIGURACOES_RECEBER_PUSH_NOTIFICATION.toString(),
        value);
  }

  Future<bool> getConfiguracoesReceberPushNotification() async {
    return _getBool(STORAGE_CHAVES.CHAVE_CONFIGURACOES_RECEBER_PUSH_NOTIFICATION
        .toString());
  }

  Future<void> setConfiguracoesTemaEscuro(bool value) async {
    await _setBool(
        STORAGE_CHAVES.CHAVE_CONFIGURACOES_TEMA_ESCURO.toString(), value);
  }

  Future<bool> getConfiguracoesTemaEscuro() async {
    return _getBool(STORAGE_CHAVES.CHAVE_CONFIGURACOES_TEMA_ESCURO.toString());
  }

  Future<void> setNumerosAleatoriosNumeroAleatorio(int value) async {
    await _setInt(
        STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString(), value);
  }

  Future<int> getNumerosAleatoriosNumeroAleatorio() async {
    return _getInt(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString());
  }

  Future<void> setNumerosAleatoriosQuantidadeCliques(int value) async {
    await _setInt(
        STORAGE_CHAVES.CHAVE_QUANTIDADE_CLIQUES.toString(), value);
  }

  Future<int> getNumerosAleatoriosAleatoriosQuantidadeCliques() async {
    return _getInt(STORAGE_CHAVES.CHAVE_QUANTIDADE_CLIQUES.toString());
  }

  Future<void> _setString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  Future<String> _getString(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  Future<void> _setStringList(String key, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(key, values);
  }

  Future<List<String>> _getStringList(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(key) ?? [];
  }

  Future<void> _setInt(String key, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(key, value);
  }

  Future<int> _getInt(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(key) ?? 0;
  }

  Future<void> _setDouble(String key, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(key, value);
  }

  Future<double> _getDouble(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key) ?? 0.0;
  }

  Future<void> _setBool(String key, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(key, value);
  }

  Future<bool> _getBool(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(key) ?? false;
  }
}
