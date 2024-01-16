import 'package:comer_bem/screens/auth.dart';
import 'package:comer_bem/screens/main_screen.dart';
import 'package:comer_bem/screens/splashScreen.dart';
import 'package:comer_bem/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    // acessando o provider de autenticação
    AuthService auth = Provider.of<AuthService>(context);

    // verifica se está logado e direciona
    if (auth.isLoading) {
      return const SplashScreen();
    } else if (auth.user == null) {
      return const Auth();
    } else {
      return const MainScreen();
    }
  }
}
