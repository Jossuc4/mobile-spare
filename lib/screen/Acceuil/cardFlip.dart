import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/gesture_flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class Cardflip extends StatefulWidget {
  final bool isDrawerVisible;
  const Cardflip({
    super.key,
    required this.isDrawerVisible,
  });

  @override
  State<Cardflip> createState() => _CardflipState();
}

class _CardflipState extends State<Cardflip> {
  final cong1 = GestureFlipCardController();
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final socketProvider = Provider.of<SocketProvider>(context);

    double consommationValue =
        double.tryParse(socketProvider.consommationData) ?? 0.0;
    String formattedValue =
        consommationValue.toStringAsFixed(3).padLeft(4, '0');

    return Column(
      children: [
        GestureFlipCard(
          controller: cong1,
          axis: FlipAxis.vertical,
          enableController: true,
          animationDuration: const Duration(seconds: 1),
          frontWidget: Stack(
            children: [
              Container(
                height: 150,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF36C18B),
                      Color(0xFF00616C),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: 15,
                      width: 90,
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? const Color(0xFF121212) : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            "CURRENT",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          constraints: const BoxConstraints(
                            maxHeight: 75,
                            maxWidth: 75,
                          ),
                          child: Image.asset(
                            'assets/Icons/Icone_2.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattedValue,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize:
                                    MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 1,
                          height: 55,
                          decoration:
                              const BoxDecoration(color: Color(0xFFD9D9D9)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                              child: Text(
                                "Kwh",
                                style: TextStyle(
                                    color: Color(0xFFD9D9D9),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5),
                              ),
                            ),
                            Text(
                              DateFormat('d MMM yyyy').format(
                                  DateTime.now()), // Formate la date actuelle
                              style: const TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 26,
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: () {
                    cong1.flipcard();
                  },
                ),
              ),
            ],
          ),
          backWidget: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF36C18B),
                  Color(0xFF00616C),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
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
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMM yyyy').format(DateTime.now()),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      Text(
                        "Energy Saving",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "35%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 27,
                  bottom: 15,
                  child: Text(
                    "0.546 Hw",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 130,
                      maxWidth: 130,
                    ),
                    child: Image.asset(
                      'assets/Images/foudre.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 75,
                  right: 120,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 50,
                      maxWidth: 50,
                    ),
                    child: Image.asset(
                      'assets/Images/foudre.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking jauge",
                style: TextStyle(
                    color: isDarkMode ? Colors.grey[100] : Colors.grey[500],
                    fontWeight: FontWeight.w600,
                    fontSize: 16.5),
              ),
              GestureDetector(
                onTap: () {
                  cong1.flipcard();
                },
                child: Container(
                  height: 25,
                  width: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFF36C18B),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x00000000).withOpacity(0.1),
                        offset: const Offset(2, 4),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Energy Saving",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
