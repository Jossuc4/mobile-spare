import 'package:flutter/material.dart';

class Parametre extends StatelessWidget {
  const Parametre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parametre')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "datafinals",
                  style: const TextStyle(fontSize: 24),
                ),
                const Text(" wh"),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
