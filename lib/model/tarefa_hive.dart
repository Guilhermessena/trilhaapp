import 'package:hive/hive.dart';
part 'tarefa_hive.g.dart';

@HiveType(typeId: 1)
class TarefaHive extends HiveObject {

  @HiveField(0)
  String descricao = '';
  @HiveField(1)
  bool concluido = false;

  TarefaHive();

  TarefaHive.criar(this.descricao, this.concluido);

}