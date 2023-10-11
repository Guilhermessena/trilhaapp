import 'package:flutter/material.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _desc = "";
  bool _concluido = false;

  Tarefa(
    this._desc,
    this._concluido,
  );

  String get id => _id;

  String get desc => _desc;

  set desc(String desc) {
    _desc = desc;
  }

  bool get concluido => _concluido;

  set concluido(bool concluido) {
    _concluido = concluido;
  }
}
