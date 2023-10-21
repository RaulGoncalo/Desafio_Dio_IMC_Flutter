class ImcModel {
  int _id;
  double _peso;
  double _altura;
  String _classificacao = "";

  ImcModel(this._id, this._peso, this._altura, this._classificacao) {}

  int get id => _id;
  void set id(int id) {
    _id = id;
  }

  double get peso => _peso;
  void set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;
  void set altura(double altura) {
    _altura = altura;
  }

  String get classificacao => _classificacao;

  void set classicaco(String classificacao) {
    _classificacao = classificacao;
  }
}
