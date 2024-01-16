import 'package:comer_bem/widgets/my_footer.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 90,
                height: 87,
                child: Image.asset('assets/images/logo.png')),
            SizedBox(height: 20),
            Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Carregando...'),
              ],
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyFooter(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
