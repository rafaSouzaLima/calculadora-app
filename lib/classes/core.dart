
import 'package:rafael3032191/classes/calculator_error.dart';
import 'package:rafael3032191/classes/notacao_polonesa_reversa.dart';

class Core {
  late String _entrada = '';
  late String _resultado = '';
  late String _erro = '';

  String get resposta => _erro.isEmpty ? _resultado + _entrada : _erro;

  void executar(String comando) {
    if(_erro.isNotEmpty) {
      _limpar();
    }

    if(comando == 'C') {
      _limpar();
    } else if(comando == '←') {
      _excluirUltimoDigito();
    } else if(comando == '=') {
      _calcularResultado();
    } else {
      if(_resultado.isNotEmpty && _entrada.isEmpty && RegExp(r'\d').hasMatch(comando)) {
        _resultado = '';
      }
      _entrada += comando;
      _filtrarEntrada();
    }
  }

  void _limpar() {
    _entrada = '';
    _resultado = '';
    _erro = '';
  }

  void _excluirUltimoDigito() {
    if(_entrada.isNotEmpty) {
      _entrada =_entrada.substring(0, _entrada.length - 1);
      return;
    }

    _limpar();
  }

  void _calcularResultado() {
    String expressao = _resultado + _entrada;
    NotacaoPolonesaReversa npr = NotacaoPolonesaReversa();

    _limpar();
    try {
      if(expressao.isNotEmpty) {
        _resultado = npr.resultado(expressao).toString();
      }
    } on CalculatorError catch(e) {
      _erro = e.message;
    }
  }

  void _filtrarEntrada() {
    String texto = _entrada;
    
    // Remove todos os caracteres diferentes de dígitos, +, -, *, / e .
    texto = texto.replaceAll(NotacaoPolonesaReversa.caracteresPermitidosRegex, '');

    // Remove todos os operadores do início
    if(_resultado.isEmpty) {
      texto = texto.replaceAll(RegExp(r'^[\+\-\×\÷]+'), '');
    }

    // Separa a string em operandos e operadores
    var operandos = texto.split(NotacaoPolonesaReversa.operadorRegex);
    operandos = operandos.where((e) => e.isNotEmpty).toList();
    var operadores = texto.split(NotacaoPolonesaReversa.operandoRegex);
    operadores = operadores.where((e) => e.isNotEmpty).toList();

    //Remove os operadores consecutivos, mantendo o último digitado
    for(int i = 0; i < operadores.length ; i++) {
      operadores[i] = operadores[i][operadores[i].length-1];
    }
    
    //Remove pontos do começo de operandos
    for(int i = 0; i < operandos.length ; i++) {
      operandos[i] = operandos[i].replaceAll(RegExp(r'^[\.]+'), '');
    }
    operandos = operandos.where((e) => e.isNotEmpty).toList();

    //Remove pontos repetidos à direita do operando
    for(int i = 0; i < operandos.length ; i++) {
      var primeiroPonto = operandos[i].indexOf('.');
      if(primeiroPonto == -1) continue;
      var antes = operandos[i].substring(0, primeiroPonto + 1);
      var depois = operandos[i].substring(primeiroPonto + 1).replaceAll('.', '');

      operandos[i] = antes + depois;
    }

    //A PARTIR DESSE PONTO, os operadores e operandos estão seguros para utilização em expressões matemáticas

    //Remover 0s à esquerda
    for(int i = 0; i < operandos.length ; i++) {
      operandos[i] = operandos[i].replaceAll(RegExp(r'^0+'), '');

      if(operandos[i].isEmpty || operandos[i].startsWith('.')) {
        operandos[i] = "0${operandos[i]}";
      }
    }

    //Juntar operandos e operadores denovo
    String novoConteudo = '';

    if(_resultado.isEmpty) {
      while(operandos.isNotEmpty || operadores.isNotEmpty) {
        if(operandos.isNotEmpty) {
          novoConteudo += operandos.removeAt(0);
        }
        if(operadores.isNotEmpty) {
          novoConteudo += operadores.removeAt(0);
        }
      }
    } else {
      while(operandos.isNotEmpty || operadores.isNotEmpty) {
        if(operadores.isNotEmpty) {
          novoConteudo += operadores.removeAt(0);
        }
        if(operandos.isNotEmpty) {
          novoConteudo += operandos.removeAt(0);
        }
      }
    }

    _entrada = novoConteudo;
  }
}