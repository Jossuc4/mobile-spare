import 'package:flutter/material.dart';
import 'package:oscapp/screen/Fournisseur/magasinliste.dart';
import 'package:oscapp/screen/Fournisseur/profesionelleliste.dart';

class FournisseurScreen extends StatefulWidget {
  const FournisseurScreen({super.key});

  @override
  State<FournisseurScreen> createState() => _FournisseurScreenState();
}

class _FournisseurScreenState extends State<FournisseurScreen> {
  bool isFournisseurSelected = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isFournisseurSelected = !isFournisseurSelected;
                });
              },
              child: Container(
                height: 75,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white, width: 0.4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x00000000).withOpacity(0.24),
                      offset: const Offset(2, 4),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      left: isFournisseurSelected ? 170 : 0,
                      right: isFournisseurSelected ? 0 : 155,
                      child: Container(
                        height: 75,
                        decoration: BoxDecoration(
                          color: const Color(0xFF36C18B),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: double.infinity,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Profesionnelles",
                              style: TextStyle(
                                color: isFournisseurSelected
                                    ? Colors.black45
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Fournisseurs",
                              style: TextStyle(
                                color: isFournisseurSelected
                                    ? Colors.white
                                    : Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: isFournisseurSelected,
              child: Magasinliste(),
            ),
            Visibility(
              visible: !isFournisseurSelected,
              child: Profesionelleliste(),
            ),
          ],
        );
      },
    );
  }
}
