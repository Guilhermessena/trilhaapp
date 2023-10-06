class TarefaSqlite {
  int _id = 0;
  String _descricao = '';
  bool _concluido = false;

  TarefaSqlite(
    this._id,
    this._descricao,
    this._concluido,
  );

  int get id => _id;
  void set id(int id) => _id = id;

  String get descricao => _descricao;
  void set descricao(String descricao) => _descricao = descricao;

  bool get concluido => _concluido;
  void set concluido(bool concluido) => _concluido = concluido;
}
