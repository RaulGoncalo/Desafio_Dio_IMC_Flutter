class Imc {
  double _peso;
  double _altura;
  String _classificacao = "";

  Imc(this._peso, this._altura) {
    calcularIMC();
  }

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;
  set altura(double altura) {
    _altura = altura;
  }

  String get classificacao => _classificacao;

  void calcularIMC() {
    double imc = _peso / (_altura * _altura);
    if (imc < 16) {
      _classificacao = "Magreza grave";
    } else if (imc < 17) {
      _classificacao = "Magreza moderada";
    } else if (imc < 18.5) {
      _classificacao = "Magreza leve";
    } else if (imc < 25) {
      _classificacao = "Saudável";
    } else if (imc < 30) {
      _classificacao = "Sobrepeso";
    } else if (imc < 35) {
      _classificacao = "Obesidade Grau I";
    } else if (imc < 40) {
      _classificacao = "Obesidade Grau II (severa)";
    } else {
      _classificacao = "Obesidade Grau III (mórbida)";
    }
  }
}
