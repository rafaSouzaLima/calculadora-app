import 'package:flutter/material.dart';

class Tecla extends StatelessWidget {
  final String texto;
  final void Function(String) comando;

  const Tecla({super.key, required this.texto, required this.comando});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          comando(texto);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
