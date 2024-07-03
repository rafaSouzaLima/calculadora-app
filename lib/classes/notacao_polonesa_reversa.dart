class NotacaoPolonesaReversa {
  static final RegExp operandoRegex = RegExp(r'[0-9\.]+');
  static final RegExp operadorRegex = RegExp(r'[\+\-\×\÷]');
  static final RegExp caracteresPermitidosRegex = RegExp(r'[^0-9\+\-\×\÷\.]');

  static int prioridade(String operador) {
    switch(operador) {
      case '+': return 1;
      case '-': return 1;
      case '×': return 2;
      case '÷': return 2;
      default:
        throw ArgumentError("Esse não é um operador válido!");
    }
  }

  static double operacao(List<double> operandos, String operador) {
    if(operandos.isEmpty) {
      throw ArgumentError('É preciso ter no mínimo 1 operando!');
    }

    switch(operador) {
      case '+': return NotacaoPolonesaReversa._adicao(operandos);
      case '-': return NotacaoPolonesaReversa._subtracao(operandos);
      case '×': return NotacaoPolonesaReversa._multiplicacao(operandos);
      case '÷': return NotacaoPolonesaReversa._divisao(operandos);
      default:
        throw ArgumentError("Esse operador não é válido em uma expressão!");
    }
  }

  static double _adicao(List<double> numeros) {
    double resultado = 0;
    for(var n in numeros) {
      resultado += n;
    }
    return resultado;
  }

  static double _subtracao(List<double> numeros) {
    if(numeros.length == 1) {
      return -numeros[0];
    }
    
    double resultado = numeros[0];

    for(var i = 1; i < numeros.length; i++) {
      resultado -= numeros[i];
    }

    return resultado;
  }

  static double _multiplicacao(List<double> numeros) {
    double resultado = 1;
    for(var n in numeros) {
      resultado *= n;
    }
    return resultado;
  }

  static double _divisao(List<double> numeros) {
    if(numeros.length < 2) {
      throw ArgumentError("Para realizar essa operação são necessários 2 operandos!");
    }

    double resultado = numeros[0];
    
    for(var i = 1; i < numeros.length ; i++) {
      if(numeros[i] == 0) {
        throw ArgumentError('Division by 0');
      }
      resultado /= numeros[i];
    }
    return resultado;
  }

  List<String> _tokenizaInfixa(String expressaoInfixa) {
    var operandos = expressaoInfixa.split(NotacaoPolonesaReversa.operadorRegex);
    operandos = operandos.where((e) => e.isNotEmpty).toList();
    var operadores = expressaoInfixa.split(NotacaoPolonesaReversa.operandoRegex);
    operadores = operadores.where((e) => e.isNotEmpty).toList();

    List<String> tokens = [];
    while(operandos.isNotEmpty || operadores.isNotEmpty) {
      if(operandos.isNotEmpty) {
        tokens.add(operandos.removeAt(0));
      }

      if(operadores.isNotEmpty) {
        tokens.add(operadores.removeAt(0));
      }
    }

    return tokens;
  }

  List<String> _tokensInfixaParaTokensPosfixa(List<String> tokensNotacaoInfixa) {

    List<String> tokensNotacaoPosfixa = [];
    List<String> stack = [];

    while(tokensNotacaoInfixa.isNotEmpty) {
      var token = tokensNotacaoInfixa.removeAt(0);

      if(NotacaoPolonesaReversa.operandoRegex.hasMatch(token)) {
        tokensNotacaoPosfixa.add(token);
      } else if(NotacaoPolonesaReversa.operadorRegex.hasMatch(token)) {
        while(stack.isNotEmpty && NotacaoPolonesaReversa.prioridade(stack.last) >= NotacaoPolonesaReversa.prioridade(token)) {
          var op = stack.removeAt(stack.length-1);
          tokensNotacaoPosfixa.add(op);
        }
        stack.add(token);
      }
    }
    while(stack.isNotEmpty) {
      tokensNotacaoPosfixa.add(stack.removeAt(stack.length-1));
    }

    return tokensNotacaoPosfixa;
  }

  double resultado(String expressaoInfixa) {
    var tokensNotacaoInfixa = _tokenizaInfixa(expressaoInfixa);
    var tokensNotacaoPosfixa = _tokensInfixaParaTokensPosfixa(tokensNotacaoInfixa);

    List<double> stack = [];

    while(tokensNotacaoPosfixa.isNotEmpty) {
      var token = tokensNotacaoPosfixa.removeAt(0);
      
      if(NotacaoPolonesaReversa.operandoRegex.hasMatch(token)) {
        stack.add(double.parse(token));
      } else if(NotacaoPolonesaReversa.operadorRegex.hasMatch(token)) {
        List<double> operandos = [];
        
        if(stack.isNotEmpty) {
          operandos.add(stack.removeAt(stack.length - 1));
        }

        if(stack.isNotEmpty) {
          operandos.add(stack.removeAt(stack.length - 1));
        }
        
        var result = operacao(operandos.reversed.toList(), token);
        stack.add(result);
      }
    }

    return stack.single;    
  }
}