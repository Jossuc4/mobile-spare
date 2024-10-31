import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'dart:convert';
import 'package:oscapp/models/socket_provider.dart';
import 'package:provider/provider.dart';

class ElectriciteScreen extends StatefulWidget {
  const ElectriciteScreen({super.key});

  @override
  State<ElectriciteScreen> createState() => _ElectriciteScreenState();
}

class _ElectriciteScreenState extends State<ElectriciteScreen>
    with SingleTickerProviderStateMixin {
  bool _isImageLoaded = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to send POST request to the API
  Future<void> sendPostRequest() async {
    final url = Uri.parse('http://34.238.235.206/iot/publish');
    final payload = {
      "state": {
        "desired": {
          "relay_1": 0,
          "relay_2": 0,
          "relay_3": 0,
          "relay_4": 0,
          "relay_5": 0,
          "relay_6": 0,
          "relay_7": 0,
          "relay_8": 0,
          "welcome": "aws-iot",
        }
      }
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        // Success
        print('Request sent successfully');
        _showNotification("Tous les appareils sont éteints");
      } else {
        // Error
        print('Failed to send request: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green, // You can customize this color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);

    double consommationValue =
        double.tryParse(socketProvider.consommationData) ?? 0.0;
    String formattedValue =
        consommationValue.toStringAsFixed(3).padLeft(4, '0');

    double facteurdepuissance =
        double.tryParse(socketProvider.facteur_puissance) ?? 0.0;
    String formattedValuepf =
        facteurdepuissance.toStringAsFixed(3).padLeft(4, '0');

    double frequencevalue = double.tryParse(socketProvider.frequence) ?? 0.0;
    String formattedValuefrequencevalue =
        frequencevalue.toStringAsFixed(3).padLeft(4, '0');

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            if (!_isImageLoaded)
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0BA56A),
                      Color(0xFF0CDE92),
                      Color(0xFF0CDE92),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(""), // Loader
                ),
              ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0BA56A),
                    Color(0xFF0CDE92),
                    Color(0xFF0CDE92),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SlideTransition(
                        position: _offsetAnimation,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 450,
                            maxWidth: 450,
                          ),
                          child: Image.asset(
                            'assets/Images/lampe.png',
                            fit: BoxFit.contain,
                            width: 500,
                            height: 500,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              if (frame != null) {
                                Future.microtask(() {
                                  setState(() {
                                    _isImageLoaded = true;
                                  });
                                });
                              }
                              return child;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35)),
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 90,
                                  ),
                                  const Text(
                                    "TURN OFF ALL DEVICES",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    color: Colors.black,
                                    width: double.infinity,
                                    height: 1,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Maximum Power",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              formattedValue,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " KWh",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Working Hrs",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "122",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " Hrs",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Devices Installed",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          " 8 Devices",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Power Factor",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              formattedValuepf,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Frequence",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              formattedValuefrequencevalue,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " Hz",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 75,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 435.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          sendPostRequest();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          constraints: const BoxConstraints(
                            maxHeight: 130,
                            maxWidth: 130,
                          ),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF0CDE92),
                                Color(0xFF0CDE92),
                                Color(0xFF0BA56A),
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/Images/power2.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 40,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
