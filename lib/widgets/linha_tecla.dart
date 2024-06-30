import 'package:flutter/material.dart';
import 'tecla.dart';

class LinhaTecla extends StatelessWidget {
  final List<Tecla> teclas;

  const LinhaTecla({super.key, required this.teclas});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: teclas,
      ),
    );
  }
}
