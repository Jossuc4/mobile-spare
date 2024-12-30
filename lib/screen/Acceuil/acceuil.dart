import 'package:flutter/material.dart';
import 'package:oscapp/screen/Acceuil/bareme.dart';
import 'package:oscapp/screen/Acceuil/cardFlip.dart';
import 'package:oscapp/screen/Acceuil/jaugeInstant.dart';
import 'package:oscapp/screen/Global/eau.dart';
import 'package:oscapp/screen/Global/electricite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Cardflip(
              isDrawerVisible: false,
            ),
            const SizedBox(height: 70),
            Stack(
              children: [
                const Jaugeinstant(),
                /*Positioned(
                  bottom: 0,
                  left: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EauScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 50,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.35),
                            offset: const Offset(-1, 2.5),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Icons/eau.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
                Positioned(
                  bottom: 0,
                  right: 30,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ElectriciteScreen()), // Remplacez NewScreen par le nom de votre écran
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                        maxWidth: 50,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.9),
                            offset: const Offset(1, 2.5),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Icons/elec.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Bareme(),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
