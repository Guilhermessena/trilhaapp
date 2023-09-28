import 'package:flutter/material.dart';

import '../shared/app_images.dart';

class ImageAssets extends StatefulWidget {
  const ImageAssets({super.key});

  @override
  State<ImageAssets> createState() => _ImageAssetsState();
}

class _ImageAssetsState extends State<ImageAssets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.logo, height: 50,),
        Image.asset(AppImages.logoDash, height: 50,),
        Image.asset(AppImages.dashPonney, height: 50,),
      ],
    );
  }
}
