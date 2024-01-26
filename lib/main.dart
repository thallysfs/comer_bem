import 'package:comer_bem/repositories/child_repository.dart';
import 'package:comer_bem/repositories/register_repository.dart';
import 'package:comer_bem/screens/consult_records_screen.dart';
import 'package:comer_bem/screens/register_activity.dart';
import 'package:comer_bem/screens/register_child.dart';
import 'package:comer_bem/service/auth_service.dart';
import 'package:comer_bem/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/color_schemes.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // declarando o provider que será acessado pela aplicação
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      // uma forma de injetar a dependência no construtor do ChildRepository que
      // exige essa dependência
      ChangeNotifierProvider(
          create: (context) =>
              ChildRepository(auth: context.read<AuthService>())),
      ChangeNotifierProvider(
          create: (context) =>
              RegisterRepository(auth: context.read<AuthService>())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Comer Bem',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              // RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12)
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    // Cor de fundo quando o botão é pressionado
                    return lightColorScheme.onPrimary;
                  }

                  return lightColorScheme.primary;
                },
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => const AuthCheck(),
          '/registerActivity': (context) => const RegisterActivity(),
          '/regiterChild': (context) => const RegisterChild(),
          '/consultRecordsScreen': (context) => const ConsultRecordsScreen()
        },
        home: const AuthCheck());
  }
}
