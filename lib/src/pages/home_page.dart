import 'package:flutter/material.dart';
import 'package:imc/src/components/custom_floating_action_button.dart';
import 'package:imc/src/components/custom_list_title.dart';
import 'package:imc/src/models/imc_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Imc> listIMC = [];

  calcularIMC() {}

  void _addImc(double peso, double altura) {
    debugPrint("Passou do onSalvar chegou no addIMC");
    listIMC.add(Imc(peso, altura));
    setState(() {});
  }

  void _deleteIMC(int index) {
    listIMC.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus IMCs")),
      floatingActionButton: CustomFloatingActionButton(onSalvar: _addImc),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: listIMC.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  CustomListTitle(
                      listImc: listIMC, index: index, onDelete: _deleteIMC),
                  const Divider(color: Colors.black),
                ],
              );
            }),
      ),
    );
  }
}
