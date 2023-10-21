import 'package:flutter/material.dart';
import 'package:imc/src/components/custom_alertdialog_error.dart';
import 'package:imc/src/components/custom_textfield.dart';
import 'package:imc/src/database/sp_db.dart';
import 'package:imc/src/pages/home_page.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorAltura = TextEditingController();
  bool isLoading = false;

  SharedPreferencesDB storage = SharedPreferencesDB();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      isLoading = true;
    });
    _controladorNome.text = await storage.getNome();
    _controladorAltura.text = (await (storage.getAltura())).toString();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Cadastro'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                      controlador: _controladorNome,
                      label: "Nome",
                      keyboardType: TextInputType.text),
                  CustomTextField(
                      controlador: _controladorAltura,
                      label: "Altura",
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 36),
                  ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        var nome = _controladorNome.text;
                        var altura = double.parse(_controladorAltura.text);

                        if (nome == "" ||
                            altura == 0 ||
                            altura < 0.6 ||
                            altura > 2.2) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertdialogError(
                                    content:
                                        "Todos os campos devem ser preenchidos.");
                              });
                        }

                        await storage.setNome(nome);
                        await storage.setAltura(altura);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertdialogError(
                                  content:
                                      "Preencha valores válidos. Altura entre 0.6 e 2.2 metros");
                            });
                      }
                    },
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                    ),
                    child: const Text(
                      "Salvar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ));
  }
}
