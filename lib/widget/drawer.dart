// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:oscapp/screen/Parametre/parametre.dart';
import 'package:oscapp/screen/Profile/profile.dart';
import 'package:oscapp/screen/Quizz/quizzgeneral.dart';
import 'package:oscapp/screen/authentification/welcome.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  final String login;
  final AdvancedDrawerController controller;

  const CustomDrawer({
    Key? key,
    required this.controller,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: -15,
            child: ElevatedButton.icon(
              onPressed: () {
                themeProvider.toggleTheme();
                print(
                    ' -------------- Dark mode is now: ${themeProvider.isDarkMode}');
              },
              icon: Icon(
                themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                color: Colors.white,
              ),
              label: const Text(""),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                login: login,
                              )));
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 120.0,
                      height: 120.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 90,
                        color: Color(0xFF36C18B),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 32),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Active Status",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: Colors.white,
                          width: 2,
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "80 Points",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  login: login,
                                )));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Utilisateur Détails",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Quizzgeneral()));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                      SizedBox(width: 15),
                      Text("Quizz Culture",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              ElevatedButton(
                onPressed: () => _showLogoutDialog(context),
                child: const Text('Déconnexion'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 55.0),
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    maxWidth: 100,
                  ),
                  child: Image.asset(
                    'assets/Icons/Icone_2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Fermer le dialog sans se déconnecter
              },
              child: const Text('Non'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialog
                _logout(context); // Appeler la fonction de déconnexion
              },
              child: const Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
    await prefs.remove('password');
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }
}
