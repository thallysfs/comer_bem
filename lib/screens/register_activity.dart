import 'package:comer_bem/models/register.dart';
import 'package:comer_bem/repositories/register_repository.dart';
import 'package:comer_bem/widgets/dropdown_children.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterActivity extends StatefulWidget {
  const RegisterActivity({super.key});

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {
  // variáveis
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _registerController = TextEditingController();
  TypeRegister? _type;
  String? _selectedChild;
  var _isLoading = false;

  // abrir tela de cadastro child
  void _openAddChild() {
    Navigator.of(context).pushNamed('/regiterChild');
  }

  //função de cadastro
  void _saveRegister() async {
    // Obtém a instância do Provider
    RegisterRepository registerRepository = context.read<RegisterRepository>();

    // o método validate retorna um booleano
    final isValid = _formKey.currentState!.validate();

    // Validar idChild
    if (_selectedChild == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione uma criança."),
        ),
      );
      return;
    }

    // Validar type
    if (_type == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecione um tipo de registro."),
        ),
      );
      return;
    }

    if (!isValid) {
      return;
    }

    // ativar o spinner de carregamento
    setState(() {
      _isLoading = true;
    });

    // Criar objeto Register
    final newRegister = Register(
      createdAt: DateTime.now().toString(),
      descriptionRegister: _registerController.text,
      type: _type!.toString(),
      idChild: _selectedChild!,
    );

    // salvar no firebase
    await registerRepository.save(newRegister);

    // fechar modal e exibir mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvo com sucesso!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      // limpar dados e parar loading
      _type = null;
      _selectedChild = null;
      _isLoading = false;
    });

    // resetar form
    _formKey.currentState!.reset();
    _registerController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // Obtém a data atual
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyy - kk:mm').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Atividade'),
      ),
      body: GestureDetector(
        onTap: () {
          // Recolhe o teclado ao tocar fora do campo de texto
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Data e imagem
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 7)),
                      Column(
                        children: [
                          const Text(
                            'Data da evolução:',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: 150,
                      height: 157,
                      child: SvgPicture.asset('assets/images/family_1.svg')),
                ],
                //SvgPicture.asset('assets/images/doctor_1.svg'),
              ),
              // Form de cadastro
              const SizedBox(height: 40),
              // o FORM começa aqui
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Row of input childName and add button
                          DropdownChildren(
                            onChildSelected: (value) {
                              setState(() {
                                _selectedChild = value;
                              });
                            },
                          ),
                          const SizedBox(width: 15),
                          IconButton(
                              onPressed: _openAddChild,
                              icon: const Icon(Icons.group_add)),
                        ],
                      ),
                      TextFormField(
                        controller: _registerController,
                        decoration:
                            const InputDecoration(labelText: 'Registro'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'É obrigatório informar um alimento ou uma habilidade';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Tipo do registro:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            title: const Text('Alimento'),
                            leading: Radio<TypeRegister>(
                              value: TypeRegister.food,
                              groupValue: _type,
                              onChanged: (value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          ListTile(
                            title: const Text('Habilidade'),
                            leading: Radio<TypeRegister>(
                              value: TypeRegister.skill,
                              groupValue: _type,
                              onChanged: (value) {
                                setState(() {
                                  _type = value;
                                });
                              },
                            ),
                            contentPadding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                      // Botão
                      ElevatedButton(
                        onPressed: _saveRegister,
                        style: ElevatedButton.styleFrom(
                          // backgroundColor:
                          //     Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(297, 40),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Salvar',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                  // Radio button do tipo
                ),
              ),
              // botão
              //rodapé
            ],
          ),
        ),
      ),
    );
  }
}
