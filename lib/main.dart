import 'package:flutter/material.dart';
import 'package:rafael3032191/classes/core.dart';
import 'package:rafael3032191/widgets/teclado.dart';
import 'package:rafael3032191/widgets/visor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculadora',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Calculadora());
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  late Core _core;

  @override
  void initState() {
    _core = Core();
    super.initState();
  }

  void _setComando(String texto) {
    setState(() {
      _core.executar(texto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visor(entrada: _core.resposta),
          const SizedBox(
            height: 10,
          ),
          Teclado(comando: _setComando),
        ],
      ),
    );
  }
}
