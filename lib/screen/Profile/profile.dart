import 'package:flutter/material.dart';
import 'package:oscapp/models/login_provider.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String login;

  const ProfileScreen({
    super.key,
    required this.login,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<int> gaugeValues = [
    75,
    50,
    90,
    30,
    60,
    80,
    45,
    73,
    55,
    60,
    35,
    15,
    0,
    0
  ];
  final List<String> monthAbbreviations = [
    'Lun',
    'Mar',
    'Mer',
    'Jeu',
    'Ven',
    'Sam',
    'Dim',
    'Lun',
    'Mar',
    'Mer',
    'Jeu',
    'Ven',
    'Sam',
    'Dim',
  ];

  final PageController _pageController =
      PageController(); // Controller for PageView

  Widget buildGaugeColumn(int index) {
    final login = Provider.of<LoginProvider>(context).login;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 23,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 23,
                height: gaugeValues[index].toDouble(),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF0CDE92),
                        Color(0xFF0BA56A),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          monthAbbreviations[index],
          style: TextStyle(
              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);

    double consommationValue =
        double.tryParse(socketProvider.consommationData) ??
            0.00; // Convertir en double
    String formattedValue = consommationValue
        .toStringAsFixed(3)
        .padLeft(2, '00'); // Formater la valeur

    return Scaffold(
      backgroundColor: Color(0xFF0CDE92),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 80 * 0.54, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 80 * 0.54, right: 25),
                    child: Text(
                      "Profile status",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 16),
                    ))
              ],
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 70),
                  margin: EdgeInsets.only(top: 80, left: 12, right: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
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
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rantsa",
                        style: TextStyle(
                            color: Color(0xFFA6A6A6),
                            fontWeight: FontWeight.w800,
                            fontSize: 27),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFF0CDE92),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0BA56A).withOpacity(0.65),
                              offset: const Offset(2, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      formattedValue,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Kwh",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  color: Colors.white,
                                  width: 2,
                                  height: 50,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  child: Text(
                                    "35%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 40),
                                  ),
                                ),
                                Text(
                                  "Saving",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Colors.white,
                                  width: 2,
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "122 Hrs",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 38.0),
                          child: Text(
                            "Spending",
                            style: TextStyle(
                                color: Color(0xFFA6A6A6),
                                fontWeight: FontWeight.w800,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 225,
                        child: PageView(
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children:
                                        List.generate(7, buildGaugeColumn),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Semaine du 14 Octobre 2024",
                                  style: TextStyle(
                                      color: Color(0xFFA6A6A6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(7,
                                        (index) => buildGaugeColumn(index + 7)),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Semaine du 21 Octobre 2024",
                                  style: TextStyle(
                                      color: Color(0xFFA6A6A6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0), // Adjust padding as needed
                        child: SmoothPageIndicator(
                          controller: _pageController, // Controller
                          count: 2, // Number of pages
                          effect: WormEffect(
                            // Customizing the dots
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: Colors.green,
                            dotColor: Colors.grey[300]!,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x00000000).withOpacity(0.24),
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 120,
                      color: Color(0xFF36C18B),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  "Details Status",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(35)),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 45.0,
                        height: 45.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Saving Energy",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                          Text(
                            "Electricity",
                            style: TextStyle(
                                color: Color(0xFF0CDE92),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "+ 35% Kwh",
                          style: TextStyle(
                              color: Color(0xFF0CDE92),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Text(
                          "25 Sept, 2024",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(35)),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 45.0,
                        height: 45.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Saving Energy",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 12),
                          ),
                          Text(
                            "Water",
                            style: TextStyle(
                                color: Color(0xFF0CDE92),
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "+ 2% m3",
                          style: TextStyle(
                              color: Color(0xFF0CDE92),
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Text(
                          "13 Sept, 2024",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
