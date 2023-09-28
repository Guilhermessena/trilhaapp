import 'package:flutter/material.dart';

import '../shared/app_images.dart';

class ListViewV extends StatefulWidget {
  const ListViewV({super.key});

  @override
  State<ListViewV> createState() => _ListViewVState();
}

class _ListViewVState extends State<ListViewV> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text("Usuario"),
          subtitle: const Text("Olá, tudo bem?"),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {},
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem(
                  value: "menu 1",
                  child: Text("menu 1"),
                ),
                const PopupMenuItem(
                  value: "menu 2",
                  child: Text("menu 2"),
                ),
                const PopupMenuItem(
                  value: "menu 3",
                  child: Text("menu 3"),
                ),
              ];
            },
          ),
          leading: Image.asset(AppImages.logo),
          isThreeLine: true,
        ),
        Image.asset(
          AppImages.logo,
        ),
        Image.asset(
          AppImages.logoDash,
        ),
        Image.asset(
          AppImages.dashPonney,
        ),
      ],
    );
  }
}
