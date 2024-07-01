import 'package:rafael3032191/classes/resposta.dart';

class Core {
  late String _expressao = '';
  late String _resultado = '';
  late String _erro = '';

  String get resposta => _erro.isEmpty ? _resultado + _expressao : _erro;

  void executar(String comando) {
    _resultado = '';
    if(comando == 'C') {
      _expressao = '';
    } else if(comando == '←') {
      _excluirUltimoDigito();
    } else {
      _expressao += comando;
    }
  }

  void _excluirUltimoDigito() {
    _expressao = _expressao.isEmpty ? _expressao : _expressao.substring(0, _expressao.length - 1);
  }

}