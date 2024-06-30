import 'package:flutter/material.dart';
import 'package:rafael3032191/widgets/linha_tecla.dart';
import 'package:rafael3032191/widgets/tecla.dart';

class Teclado extends StatelessWidget {
  final void Function(String) comando;

  const Teclado({super.key, required this.comando});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: <Widget>[
          LinhaTecla(teclas: [
            Tecla(texto: "←", comando: comando),
            Tecla(texto: "C", comando: comando),
          ]),
          LinhaTecla(teclas: [
            Tecla(texto: "7", comando: comando),
            Tecla(texto: "8", comando: comando),
            Tecla(texto: "9", comando: comando),
            Tecla(texto: "÷", comando: comando),
          ]),
          LinhaTecla(teclas: [
            Tecla(texto: "4", comando: comando),
            Tecla(texto: "5", comando: comando),
            Tecla(texto: "6", comando: comando),
            Tecla(texto: "×", comando: comando),
          ]),
          LinhaTecla(teclas: [
            Tecla(texto: "1", comando: comando),
            Tecla(texto: "2", comando: comando),
            Tecla(texto: "3", comando: comando),
            Tecla(texto: "-", comando: comando),
          ]),
          LinhaTecla(teclas: [
            Tecla(texto: ".", comando: comando),
            Tecla(texto: "0", comando: comando),
            Tecla(texto: "=", comando: comando),
            Tecla(texto: "+", comando: comando),
          ]),
        ],
      ),
    );
  }
}
