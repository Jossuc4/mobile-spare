import 'dart:math';
import 'package:flutter/material.dart';
import 'package:oscapp/models/plafond_provider.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:oscapp/screen/Acceuil/gauge_painter.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class Jaugeinstant extends StatefulWidget {
  final double intercircleSize; // Taille du cercle interne

  const Jaugeinstant({super.key, this.intercircleSize = 70.0});

  @override
  State<Jaugeinstant> createState() => _JaugeinstantState();
}

class _JaugeinstantState extends State<Jaugeinstant>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _oldValue = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketProvider = Provider.of<SocketProvider>(context);
    double vitesseValue = double.tryParse(socketProvider.vitesseData) ?? 0;

    // Update the animation whenever the value changes
    if (vitesseValue != _oldValue) {
      _animation = Tween<double>(begin: _oldValue, end: vitesseValue)
          .animate(_animationController);
      _oldValue = vitesseValue;
      _animationController.forward(from: 0);
    }

    return Center(
      child: Column(
        children: [
          Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.isDarkMode;
            final plafond = context.watch<PlafondProvider>().plafond;
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(235, 235),
                  painter: GaugePainter(
                    _animation.value,
                    widget.intercircleSize,
                    isDarkMode,
                    plafond,
                  ),
                );
              },
            );
          }),
          const SizedBox(height: 70),
          Consumer<PlafondProvider>(
            builder: (context, plafondProvider, child) {
              return Column(
                children: [
                  Text("Maximum: ${plafondProvider.plafond} Wh"),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _showPlafondDialog(context),
            child: Container(
              height: 30,
              width: 175,
              decoration: BoxDecoration(
                color: Colors.grey[350]!,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 0.5),
              ),
              child: const Center(
                child: Text(
                  "Change Maximum",
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
        ],
      ),
    );
  }

  void _showPlafondDialog(BuildContext context) {
    double newPlafond =
        context.read<PlafondProvider>().plafond; // Get current plafond

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Changer le Plafond'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Nouveau plafond'),
            onChanged: (value) {
              newPlafond = double.tryParse(value) ?? newPlafond;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                context.read<PlafondProvider>().setPlafond(newPlafond);
                Navigator.of(context).pop();
              },
              child: const Text('Changer'),
            ),
          ],
        );
      },
    );
  }
}
