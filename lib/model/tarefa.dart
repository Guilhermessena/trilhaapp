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

  void set desc(String desc) {
    _desc = desc;
  }

  bool get concluido => _concluido;

  void set concluido(bool concluido) {
    _concluido = concluido;
  }
}
