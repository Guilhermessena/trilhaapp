class Configuracoes {
  String _nomeUsuario = "";
  double _altura = 0.0;
  bool _receberPushNotification = false;
  bool _temaEscuro = false;

  Configuracoes.vazio() {
    _nomeUsuario = "";
    _altura = 0;
    _receberPushNotification = false;
    _temaEscuro = false;
  }

  Configuracoes(
    this._nomeUsuario,
    this._altura,
    this._receberPushNotification,
    this._temaEscuro,
  );

  String get nomeUsuario => _nomeUsuario;
  set nomeUsuario(String nomeUsuario) => _nomeUsuario = nomeUsuario;

  double get altura => _altura;
  set altura(double altura) => _altura = altura;

  bool get receberPushNotification => _receberPushNotification;
  set receberPushNotification(bool receberPushNotification) =>
      _receberPushNotification = receberPushNotification;

  bool get temaEscuro => _temaEscuro;
  set temaEscuro(bool temaEscuro) => _temaEscuro = temaEscuro;
}
