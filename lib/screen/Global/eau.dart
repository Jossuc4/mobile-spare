import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oscapp/screen/Global/waveAnimation.dart';
import 'dart:ui';

class EauScreen extends StatefulWidget {
  const EauScreen({super.key});

  @override
  State<EauScreen> createState() => _EauScreenState();
}

class _EauScreenState extends State<EauScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _waveAnimation;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _heightAnimation = Tween<double>(begin: 0, end: 0.55).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _waveAnimation = Tween<double>(begin: 0, end: 2 * 3.1416).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Waves animations
          Positioned(
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: WaveClipper(
                          _heightAnimation.value, -_waveAnimation.value + 5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: WaveClipper(
                          _heightAnimation.value, _waveAnimation.value),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Current Status",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0CDE92),
                      Color(0xFF0CDE92),
                      Color(0xFF0BA56A),
                    ],
                  ),
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
                        Text(
                          "254 ml ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
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
                            "31%",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 40),
                          ),
                        ),
                        Text(
                          "Water Saving",
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
                          "148 Hrs",
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
              SizedBox(
                height: 75,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 265.0,
                      height: 265.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.8),
                          width: 5.0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(height: 50),
                                SizedBox(
                                  height: 120,
                                  child: Text(
                                    "67%",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 100,
                                    ),
                                  ),
                                ),
                                Text(
                                  "of 2800 ml",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bordure animée autour du cercle
                    AnimatedBuilder(
                      animation: _rotationController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: RotatingBorderPainter(
                            angle: _rotationController.value *
                                2 *
                                pi, // Rotation complète
                            strokeWidth: 8, // Largeur de la bordure
                          ),
                          child: SizedBox(
                            width: 265.0,
                            height: 265.0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bouton de retour
          Positioned(
            top: 45,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          Column(
            children: [
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Color(0xFF0CDE92),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0BA56A).withOpacity(0.65),
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 65,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RotatingBorderPainter extends CustomPainter {
  final double angle;
  final double strokeWidth;

  RotatingBorderPainter({required this.angle, this.strokeWidth = 10});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2.01;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Arrondi des extrémités de l'arc

    // Longueur de l'arc (90° ici)
    final arcLength = pi / 3;

    // Dessiner l'arc avec rotation
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      angle, // Position actuelle de l'arc
      arcLength, // Longueur de l'arc
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
