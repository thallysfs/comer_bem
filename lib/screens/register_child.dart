import 'package:comer_bem/models/child.dart';
import 'package:comer_bem/repositories/child_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Definição do tipo Dropdown menu
enum GenderLabel {
  male('Macho', 'male'),
  female('Fêmea', 'female');

  const GenderLabel(this.label, this.value);
  final String label;
  final String value;
}

class RegisterChild extends StatefulWidget {
  const RegisterChild({super.key});

  @override
  State<RegisterChild> createState() => _RegisterChildState();
}

class _RegisterChildState extends State<RegisterChild> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _childNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  // usando o tipo criado acima
  GenderLabel? selectedGender;
  final _birthdayController = TextEditingController();
  final _responsibleController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _childNameController.dispose();
    _birthdayController.dispose();
    _responsibleController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _saveChild() async {
    // Obtém a instância do ChildRepository do Provider
    ChildRepository childRepository = context.read<ChildRepository>();

    // o método validate retorna um booleano
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    // ativar o spinner de carregamento
    setState(() {
      _isLoading = true;
    });

    // criar objeto Child
    final newChild = Child(
      name: _childNameController.text,
      gender: _genderController.text,
      birthday: _birthdayController.text,
      responsible: _responsibleController.text,
    );

    // salvar no firebase
    await childRepository.save(newChild);

    // resetar form
    _formKey.currentState!.reset();

    // fechar modal e exibir mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvo com sucesso!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Criança',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Recolhe o teclado ao tocar fora do campo de texto
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                width: 160,
                height: 119,
                child: SvgPicture.asset('assets/images/child.svg'),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _childNameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 4) {
                          return 'Por favor use um nome válido (pelo menos 4 caracteres)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _birthdayController,
                      decoration: const InputDecoration(
                          labelText: 'Data de nascimento'),
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'A data de nascimento é obrigatória';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _responsibleController,
                      decoration:
                          const InputDecoration(labelText: 'Responsável'),
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Preencha o nome do responsável';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    DropdownMenu<GenderLabel>(
                      initialSelection: GenderLabel.male,
                      controller: _genderController,
                      label: const Text('Sexo'),
                      onSelected: (GenderLabel? gender) {
                        setState(() {
                          selectedGender = gender;
                        });
                      },
                      dropdownMenuEntries: GenderLabel.values
                          .map<DropdownMenuEntry<GenderLabel>>(
                              (GenderLabel gender) {
                        return DropdownMenuEntry<GenderLabel>(
                          value: gender,
                          label: gender.label,
                          style: MenuItemButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                    Column(
                      children: [
                        _isLoading
                            ? const CircularProgressIndicator()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          width: 2.0),
                                      minimumSize: const Size(110, 40),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancelar',
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(110, 40)),
                                    onPressed: _saveChild,
                                    child: const Text(
                                      'Salvar',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
