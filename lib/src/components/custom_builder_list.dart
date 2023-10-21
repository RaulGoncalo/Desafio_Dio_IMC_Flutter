import 'package:flutter/material.dart';
import 'package:imc/src/models/imc_model.dart';

class CustomBuilderList extends StatefulWidget {
  const CustomBuilderList(
      {super.key,
      required this.listIMC,
      required this.onDelete,
      required this.nome});
  final List<ImcModel> listIMC;
  final Function(int) onDelete;
  final String nome;

  @override
  State<CustomBuilderList> createState() => _CustomBuilderListState();
}

class _CustomBuilderListState extends State<CustomBuilderList> {
  late List<ImcModel> listIMC;
  @override
  void initState() {
    super.initState();
    listIMC = widget.listIMC;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listIMC.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                    "${widget.nome} você esta com: ${listIMC[index].classificacao}"),
                subtitle: Text(
                    "Altura: ${listIMC[index].altura.toString()} m  Peso:  ${listIMC[index].peso.toString()} kg"),
                trailing: IconButton(
                    onPressed: () {
                      widget.onDelete(listIMC[index].id);
                    },
                    icon: const Icon(Icons.delete)),
                iconColor: Colors.red,
              ),
              const Divider(),
            ],
          );
        });
  }
}
