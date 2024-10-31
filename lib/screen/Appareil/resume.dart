import 'package:flutter/material.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:provider/provider.dart';

class ResumeAll extends StatefulWidget {
  const ResumeAll({super.key});

  @override
  State<ResumeAll> createState() => _ResumeAllState();
}

class _ResumeAllState extends State<ResumeAll> {
  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);

    double consommationValue =
        double.tryParse(socketProvider.consommationData) ??
            0.0; // Convertir en double
    String formattedValue = consommationValue
        .toStringAsFixed(3)
        .padLeft(4, '0'); // Formater la valeur

    return Container(
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.white],
          ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: double.infinity,
                width: 170,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF36C18B),
                        Color(0xFF36C18B),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 0.4)),
                child: Center(
                    child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 25),
                      constraints: const BoxConstraints(
                        maxHeight: 40,
                        maxWidth: 40,
                      ),
                      child: Image.asset(
                        'assets/Logos/Energy.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Text(
                      "Energy",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                  ],
                ))),
            Container(
                height: double.infinity,
                width: 140,
                margin: EdgeInsets.only(top: 15, right: 17),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.white, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 0.4)),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formattedValue,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        Text(
                          "Kwh",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      "8 Devices connected",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                  ],
                ))),
          ],
        ));
  }
}
