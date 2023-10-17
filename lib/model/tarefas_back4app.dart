class TarefasBack4app {
  List<TarefaBack4app> _tarefa = [];

  TarefasBack4app(List<TarefaBack4app>? tarefa) {
    if (tarefa != null) {
      _tarefa = tarefa;
    }
  }

  List<TarefaBack4app> get tarefa => _tarefa;
  set tarefa(List<TarefaBack4app> tarefa) => _tarefa = tarefa;

  TarefasBack4app.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _tarefa = <TarefaBack4app>[];
      json['results'].forEach((v) {
        _tarefa.add(TarefaBack4app.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = _tarefa.map((v) => v.toJson()).toList();
    return data;
  }
}

class TarefaBack4app {
  String _objectId = '';
  String _dsDescricao = '';
  bool _concluido = false;
  String _createdAt = '';
  String _updatedAt = '';

  TarefaBack4app(
    String? objectId,
    String? dsDescricao,
    bool? concluido,
    String? createdAt,
    String? updatedAt,
  ) {
    if (objectId != null) {
      _objectId = objectId;
    }
    if (dsDescricao != null) {
      _dsDescricao = dsDescricao;
    }
    if (concluido != null) {
      _concluido = concluido;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  TarefaBack4app.create(
    String? dsDescricao,
    bool? concluido,
  ) {
    if (dsDescricao != null) {
      _dsDescricao = dsDescricao;
    }
    if (concluido != null) {
      _concluido = concluido;
    }
  }

  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId!;
  String? get dsDescricao => _dsDescricao;
  set dsDescricao(String? dsDescricao) => _dsDescricao = dsDescricao!;
  bool? get concluido => _concluido;
  set concluido(bool? concluido) => _concluido = concluido!;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt!;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt!;

  TarefaBack4app.fromJson(Map<String, dynamic> json) {
    _objectId = json['objectId'];
    _dsDescricao = json['ds_descricao'];
    _concluido = json['concluido'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = _objectId;
    data['ds_descricao'] = _dsDescricao;
    data['concluido'] = _concluido;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ds_descricao'] = _dsDescricao;
    data['concluido'] = _concluido;
    return data;
  }
}
