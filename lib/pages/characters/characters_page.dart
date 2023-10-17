import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_marvel.dart';
import 'package:trilhaapp/repository/marvel/marvel_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final _scrollController = ScrollController();
  late MarvelRepository marvelRepository;
  var characters = CharactersMarvel();
  var offset = 0;
  var carregando = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posPaginacao = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posPaginacao) {
        carregarDados();
      }
    });
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    marvelRepository = MarvelRepository();
    if (carregando) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return characters.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            'Herois: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  characters.data == null || characters.data!.results == null
                      ? 0
                      : characters.data!.results!.length,
              itemBuilder: (context, index) {
                var character = characters.data!.results![index];
                return Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        '${character.thumbnail!.path!}.${character.thumbnail!.extension!}',
                        width: 120,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                character.description ?? '',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          !carregando
              ? ElevatedButton(
                  onPressed: () {
                    carregarDados();
                  },
                  child: const Text('carregar mais itens'),
                )
              : const CircularProgressIndicator()
        ],
      ),
    ));
  }
}
