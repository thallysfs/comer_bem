import 'package:comer_bem/service/auth_service.dart';
import 'package:comer_bem/widgets/activity_card.dart';
import 'package:comer_bem/widgets/my_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          top: 30,
          bottom: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              padding: const EdgeInsets.only(left: 320),
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              width: 90,
              height: 87,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cards
                ActivityCard(
                  name: 'Reg. atividade',
                  icon: Icons.addchart,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/registerActivity');
                  },
                ),
                ActivityCard(
                  name: 'Consultar Reg',
                  icon: Icons.plagiarism_outlined,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/consultRecordsScreen');
                  },
                ),
                ActivityCard(
                  name: 'Adm. paciente',
                  icon: Icons.person_add,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/regiterChild');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cards
                ActivityCard(
                  name: 'Receituário',
                  icon: Icons.assignment_add,
                  onPressed: () {},
                ),
                ActivityCard(
                  name: 'Configuração',
                  icon: Icons.settings_outlined,
                  onPressed: () {},
                ),
                ActivityCard(
                  name: 'Sair',
                  icon: Icons.exit_to_app,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              width: 251,
              height: 206,
              child: SvgPicture.asset('assets/images/doctor_1.svg'),
              //Image.asset('assets/images/doctor_1.svg'),
            ),
            const MyFooter(),
          ],
        ),
      ),
    );
  }
}
