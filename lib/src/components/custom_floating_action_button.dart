import 'package:flutter/material.dart';
import 'package:imc/src/components/custom_alertdialog_error.dart';
import 'package:imc/src/components/custom_textfield.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key, required this.onSalvar});
  final Function(double, double) onSalvar;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  final _controladorPeso = TextEditingController();
  final _controladorAltura = TextEditingController();

  void showDialogError(String? mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertdialogError(content: mensagem!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _controladorPeso.clear();
        _controladorAltura.clear();
        showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: const Text("Adidionar IMC"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextField(controlador: _controladorPeso, label: "Peso"),
                  CustomTextField(
                      controlador: _controladorAltura, label: "Altura"),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      double peso = double.parse(_controladorPeso.text);
                      double altura = double.parse(_controladorAltura.text);

                      // Certifica-se de que peso e altura são válidos
                      if (peso <= 0 || altura <= 0) {
                        // Tratar valores inválidos, por exemplo, exibindo uma mensagem de erro
                        showDialogError(
                            'Valores de peso e altura devem ser maiores que zero.');
                      } else {
                        // Valores válidos, instancia a classe IMC
                        widget.onSalvar(peso, altura);
                        Navigator.of(context).pop();
                      }
                    } catch (error) {
                      // Tratar erros de análise, por exemplo, exibindo uma mensagem de erro
                      showDialogError(
                          'Erro ao analisar os valores de peso e altura.');
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
