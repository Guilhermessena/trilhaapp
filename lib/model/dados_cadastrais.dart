import 'package:hive/hive.dart';
part 'dados_cadastrais.g.dart';

@HiveType(typeId: 0)
class DadosCadastrais extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  DateTime? dtNasc;

  @HiveField(2)
  String? nivelExp;

  @HiveField(3)
  List<String> linguagens = [];

  @HiveField(4)
  int? tempoExp;

  @HiveField(5)
  double? pretensaoSalarial;

  DadosCadastrais();

  DadosCadastrais.vazio() {
    nome = '';
    dtNasc = null;
    nivelExp = '';
    linguagens = [];
    tempoExp = 0;
    pretensaoSalarial = 0;
  }
}
