import 'dart:async';
import 'dart:math';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final NotchBottomBarController controller;
  final PageController pageController;

  const CustomBottomNavigationBar({
    super.key,
    required this.controller,
    required this.pageController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  Timer? _navigationTimer;

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedNotchBottomBar(
        notchBottomBarController: widget.controller,
        color: isDarkMode ? Colors.grey[100]! : Colors.white,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 4.5,
        kBottomRadius: 20.0,
        notchShader: const SweepGradient(
          startAngle: 0,
          endAngle: pi / 2,
          colors: [
            Color(0xFF36C18B),
            Color(0xFF00616C),
          ],
          tileMode: TileMode.mirror,
        ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
        notchColor: Colors.grey[350]!,
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: true,
        durationInMilliSeconds: 500,
        itemLabelStyle: const TextStyle(fontSize: 10),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.devices,
              color: Colors.black54,
            ),
            activeItem: Icon(
              Icons.devices,
              color: Colors.white,
            ),
            itemLabel: 'Appareil',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.black54,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.business,
              color: Colors.black54,
            ),
            activeItem: Icon(
              Icons.business,
              color: Colors.white,
            ),
            itemLabel: 'Fournisseur',
          ),
        ],
        onTap: (index) {
          if ((_currentIndex - index).abs() > 1) {
            int direction = (_currentIndex < index) ? 1 : -1;

            List<int> indicesToVisit = [];
            int current = _currentIndex;
            while (current != index) {
              current += direction;
              indicesToVisit.add(current);
            }

            Future<void> navigateThroughIndices() async {
              for (int i = 0; i < indicesToVisit.length; i++) {
                await Future.delayed(const Duration(milliseconds: 500));
                widget.pageController.animateToPage(
                  indicesToVisit[i],
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
              setState(() {
                _currentIndex = index;
              });
            }

            navigateThroughIndices();
          } else {
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
            setState(() {
              _currentIndex = index;
            });
          }
        },
        kIconSize: 24.0,
      ),
    );
  }
}
