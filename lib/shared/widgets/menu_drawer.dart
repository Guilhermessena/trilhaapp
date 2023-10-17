import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/characters/characters_page.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/posts_page.dart';
import '../../pages/configuracoes/configuracoes__hive_page.dart';
import '../../pages/dados_cadastrais/dados_cadastrais_hive.dart';
import '../../pages/numeros_aleatorios/numeros_aleatorios_hive_page.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (context) {
                  return const Wrap(
                    children: [
                      ListTile(
                        title: Text("Camera"),
                        leading: Icon(Icons.photo_camera_outlined),
                      ),
                      ListTile(
                        title: Text("Galeria"),
                        leading: Icon(Icons.photo_library_outlined),
                      )
                    ],
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
              ),
              accountName: const Text("userguilherme"),
              accountEmail: const Text("email@gmail.com"),
            ),
          ),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person_2_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Dados cadastrais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DadosCadastraisHive(),
                  ));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.note_alt_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Termos de uso e privacidade"),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 16.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          "Termos de uso e privacidade",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          height: 10,
                        ),
                        const Text(
                          "Maecenas mollis pulvinar finibus. Suspendisse potenti. Donec ullamcorper scelerisque libero elementum cursus. Aenean nec facilisis orci. Curabitur a facilisis felis. Suspendisse euismod tellus vel lorem consectetur, sed tincidunt arcu tempor. Duis erat velit, mollis sed mollis ut, semper ut massa. Praesent id malesuada massa. Proin feugiat sollicitudin lectus dignissim venenatis. Cras at quam ac nisi sodales pulvinar sodales congue libero. Etiam gravida, ipsum.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.settings_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Configurações"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfiguracoesHivePage(),
                  ));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.numbers_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Gerador de números"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NumerosAleatoriosHivePage(),
                  ));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.post_add_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Posts"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostsPage(),
                  ));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.hdr_strong),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Herois"),
                  ],
                )),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CharactersPage(),
                  ));
            },
          ),
          const Divider(),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.exit_to_app_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Sair"),
                  ],
                )),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 8,
                    title: const Text("Trilha App"),
                    content:
                        const Wrap(children: [Text("Deseja sair do app?")]),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ));
                        },
                        child: const Text("Sim"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Não"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
