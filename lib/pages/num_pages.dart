import 'package:flutter/material.dart';

class NumPage1 extends StatefulWidget {
  const NumPage1({super.key});

  @override
  State<NumPage1> createState() => _NumPage1State();
}

class _NumPage1State extends State<NumPage1> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueGrey,);
  }
}

class NumPage2 extends StatefulWidget {
  const NumPage2({super.key});

  @override
  State<NumPage2> createState() => _NumPage2State();
}

class _NumPage2State extends State<NumPage2> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.orange,);
  }
}

class NumPage3 extends StatefulWidget {
  const NumPage3({super.key});

  @override
  State<NumPage3> createState() => _NumPage3State();
}

class _NumPage3State extends State<NumPage3> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.yellow,);
  }
}