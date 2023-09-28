import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/app_images.dart';

class ListViewH extends StatelessWidget {
  const ListViewH({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 1,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Image.asset(
                  AppImages.dashPonney,
                ),
              ),
              Card(elevation: 8, child: Image.asset(AppImages.logo)),
              Card(elevation: 8, child: Image.asset(AppImages.logoDash)),
            ],
          ),
        ),
        Expanded(flex: 3, child: Container()),
      ]),
    );
  }
}
