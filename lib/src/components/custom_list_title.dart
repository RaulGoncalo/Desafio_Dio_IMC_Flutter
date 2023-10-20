import 'package:flutter/material.dart';
import 'package:imc/src/models/imc_model.dart';

class CustomListTitle extends StatefulWidget {
  const CustomListTitle(
      {super.key,
      required this.listImc,
      required this.index,
      required this.onDelete});
  final List<Imc> listImc;
  final int index;
  final Function(int) onDelete;

  @override
  State<CustomListTitle> createState() => _CustomListTitleState();
}

class _CustomListTitleState extends State<CustomListTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.listImc[widget.index].classificacao),
      subtitle: Text(
          "Altura: ${widget.listImc[widget.index].altura.toString()} m  Peso:  ${widget.listImc[widget.index].peso.toString()} kg"),
      trailing: IconButton(
          onPressed: () {
            widget.onDelete(widget.index);
          },
          icon: const Icon(Icons.delete)),
      iconColor: Colors.red,
    );
  }
}
