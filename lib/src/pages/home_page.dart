import 'package:flutter/material.dart';
import 'package:imc/src/models/imc_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controladorPeso = TextEditingController();
  final _controladorAltura = TextEditingController();

  List<Imc> listIMC = [];

  calcularIMC() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus IMCs")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controladorPeso.clear();
          _controladorAltura.clear();
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: Text("Adidionar IMC"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _controladorPeso,
                      decoration: InputDecoration(labelText: "Peso"),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _controladorAltura,
                      decoration: InputDecoration(labelText: "Altura"),
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        double peso = double.parse(_controladorPeso.text);
                        double altura = double.parse(_controladorAltura.text);

                        // Certifica-se de que peso e altura são válidos
                        if (peso <= 0 || altura <= 0) {
                          // Tratar valores inválidos, por exemplo, exibindo uma mensagem de erro
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Erro'),
                                content: Text(
                                    'Valores de peso e altura devem ser maiores que zero.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Valores válidos, instancia a classe IMC
                          listIMC.add(Imc(peso, altura));
                          setState(() {});
                          Navigator.of(context).pop();
                        }
                      } catch (error) {
                        // Tratar erros de análise, por exemplo, exibindo uma mensagem de erro
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Erro'),
                              content: Text(
                                  'Erro ao analisar os valores de peso e altura.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: listIMC.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(listIMC[index].classificacao),
                    subtitle: Text(
                        "Altura: ${listIMC[index].altura.toString()} m  Peso:  ${listIMC[index].peso.toString()} kg"),
                    trailing: IconButton(
                        onPressed: () {
                          listIMC.removeAt(index);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                    iconColor: Colors.red,
                  ),
                  const Divider(color: Colors.black),
                ],
              );
            }),
      ),
    );
  }
}
