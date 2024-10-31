import 'package:flutter/material.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:provider/provider.dart';

class Bareme extends StatefulWidget {
  const Bareme({super.key});

  @override
  State<Bareme> createState() => _BaremeState();
}

class _BaremeState extends State<Bareme> {
  double jaugeValue = 68.0;
  double plafond = 2.5;
  bool isLastContainerVisible = false; // Boolean to control the visibility

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);

    double consommationValue =
        double.tryParse(socketProvider.consommationData) ?? 0.0;
    String formattedValue =
        consommationValue.toStringAsFixed(3).padLeft(4, '0');

    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Jauge d'Economie",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          fontSize: 16.5),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: LinearProgressIndicator(
                        value: consommationValue / plafond,
                        minHeight: 15,
                        backgroundColor: Colors.grey[150],
                        color: const Color(0xFF0CDE92),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$consommationValue Kwh',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5),
                          ),
                          Text(
                            "$plafond Kwh",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 25,
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.grey,
                    size: 18,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        double tempPlafond = plafond;
                        return AlertDialog(
                          title: const Text("Changer le plafond"),
                          content: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              tempPlafond = double.tryParse(value) ?? plafond;
                            },
                            decoration: const InputDecoration(
                              labelText: "Nouveau plafond",
                              hintText: "Entrez une valeur numérique",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler"),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  plafond = tempPlafond;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text("Confirmer"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () {
            setState(() {
              isLastContainerVisible =
                  !isLastContainerVisible; // Toggle visibility
            });
          },
          child: Container(
            height: 40,
            width: 235,
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
                "Economie Personalisé",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        if (isLastContainerVisible) // Show the container if true
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Le choix de choisir la valeur de la jauge d'economie",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Spare vous propose de fixer la consommation à 2.25 Kwh par rapport à votre encienne consomation",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          fontSize: 16.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLastContainerVisible =
                                !isLastContainerVisible; // Toggle visibility
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 175,
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
                              "Appliquer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
