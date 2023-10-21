import 'package:flutter/material.dart';
import 'package:imc/src/components/custom_floating_action_button.dart';
import 'package:imc/src/components/custom_builder_list.dart';
import 'package:imc/src/database/sp_db.dart';
import 'package:imc/src/models/imc_model.dart';
import 'package:imc/src/pages/cadastro_page.dart';
import 'package:imc/src/repository/imc_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferencesDB storage = SharedPreferencesDB();
  IMCRepository imcRepository = IMCRepository();

  late Future<List<ImcModel>> _listIMCFuture;
  String nome = "";
  double altura = 0.0;

  @override
  void initState() {
    super.initState();
    _listIMCFuture = carregarDados();
  }

  Future<List<ImcModel>> carregarDados() async {
    final loadedListIMC = await imcRepository.obterDados();
    final loadedNome = await storage.getNome();
    final loadedAltura = await storage.getAltura();

    setState(() {
      nome = loadedNome;
      altura = loadedAltura;
    });

    return loadedListIMC;
  }

  void _addImc(double peso) async {
    await imcRepository
        .salvar(ImcModel(0, peso, altura, calcularIMC(peso, altura)));
    setState(() {
      _listIMCFuture = carregarDados();
    });
  }

  void _deleteIMC(int id) async {
    await imcRepository.deletar(id);
    setState(() {
      _listIMCFuture = carregarDados();
    });
  }

  String calcularIMC(double peso, double altura) {
    var classificacao = "";
    double imc = peso / (altura * altura);
    if (imc < 16) {
      classificacao = "Magreza grave";
    } else if (imc < 17) {
      classificacao = "Magreza moderada";
    } else if (imc < 18.5) {
      classificacao = "Magreza leve";
    } else if (imc < 25) {
      classificacao = "Saudável";
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
    } else if (imc < 35) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 40) {
      classificacao = "Obesidade Grau II (severa)";
    } else {
      classificacao = "Obesidade Grau III (mórbida)";
    }

    return classificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus IMCs"),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CadastroPage(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          );
        }),
      ),
      floatingActionButton: CustomFloatingActionButton(onSalvar: _addImc),
      body: FutureBuilder(
        future: _listIMCFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final listIMC = snapshot.data as List<ImcModel>;
            return Container(
              padding: const EdgeInsets.all(8),
              child: CustomBuilderList(
                  listIMC: listIMC, onDelete: _deleteIMC, nome: nome),
            );
          }
        },
      ),
    );
  }
}
