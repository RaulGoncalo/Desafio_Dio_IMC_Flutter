import 'package:imc/src/database/sqlite_db.dart';
import 'package:imc/src/models/imc_model.dart';

class IMCRepository {
  Future<List<ImcModel>> obterDados() async {
    List<ImcModel> imcs = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result =
        await db.rawQuery("SELECT id, altura, peso, classificacao FROM imcs");
    for (var element in result) {
      imcs.add(
        ImcModel(
            int.parse(element["id"].toString()),
            double.parse(element["peso"].toString()),
            double.parse(element["altura"].toString()),
            element["classificacao"].toString()),
      );
    }
    return imcs;
  }

  Future<void> salvar(ImcModel imcModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'INSERT INTO imcs (peso, altura, classificacao) values(?,?,?)',
        [imcModel.peso, imcModel.altura, imcModel.classificacao]);
  }

  Future<void> deletar(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM imcs WHERE id = ?', [id]);
  }
}
