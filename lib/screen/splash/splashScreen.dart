import 'package:flutter/material.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:oscapp/screen/home.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    /*final socketProvider = Provider.of<SocketProvider>(context, listen: false);
    final fetchDataProvider =
        Provider.of<FetchDataProvider>(context, listen: false);

    while (!socketProvider.isConnected) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    await fetchDataProvider.fetchShops();
    await fetchDataProvider.fetchProData();
    await fetchDataProvider.fetchDeviceData();
    await fetchDataProvider.fetchNotifications();

    await Future.delayed(const Duration(milliseconds: 500));

    await Future.delayed(const Duration(milliseconds: 500));
    */
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildHomeScreen(),
          SlideTransition(
            position: _animation,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0CDE92),
                    Color(0xFF0CDE92),
                    Color(0xFF0CDE92),
                    Color(0xFF0BA56A),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 125,
                    maxWidth: 125,
                  ),
                  child: Image.asset(
                    'assets/Icons/Icone_2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return const MyHomePage(isDrawerVisible: false);
  }
}
