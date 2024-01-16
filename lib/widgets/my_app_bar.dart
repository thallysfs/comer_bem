import 'package:comer_bem/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ! Deprecated !!!
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, this.title, this.actions, this.isLeading = false});

  final String? title;
  final List<Widget>? actions;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    // acessando o provider de autenticação
    List<Widget> appBarActions = actions ??
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.read<AuthService>().signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          )
        ];

    final customiseLeading = IconButton(
      icon: const Icon(Icons.arrow_back),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () => Navigator.pop(context),
    );

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      // ícone para voltar
      leading: isLeading ? customiseLeading : null,
      actions: appBarActions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
