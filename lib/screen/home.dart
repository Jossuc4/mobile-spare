import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:oscapp/screen/Acceuil/acceuil.dart';
import 'package:oscapp/screen/Appareil/appareil.dart';
import 'package:oscapp/screen/Fournisseur/fournisseur.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:oscapp/widget/appBar.dart';
import 'package:oscapp/widget/bottomNavigationBar.dart';
import 'package:oscapp/widget/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  final bool isDrawerVisible;
  const MyHomePage({
    super.key,
    required this.isDrawerVisible,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String _login = '';
  final _advancedDrawerController = AdvancedDrawerController();
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    _loadLogin();
  }

  Future<void> _loadLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? login = prefs.getString('login');
    setState(() {
      _login = login ?? 'Guest';
    });
  }

  final List<Widget> _screens = [
    const AppareilScreen(
      isDrawerVisible: false,
    ),
    const HomeScreen(),
    const FournisseurScreen(),
  ];

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
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
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.9,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      drawer: CustomDrawer(
        controller: _advancedDrawerController,
        login: _login, // Pass the login to CustomDrawer
      ),
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.grey[50],
        appBar: CustomAppBar(
          login: _login, // Pass the login to CustomAppBar
          onMenuPressed: _handleMenuButtonPressed,
          isDrawerVisible: _advancedDrawerController.value.visible,
        ),
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            _controller.jumpTo(index);
          },
          children: _screens,
        ),
        extendBody: true,
        bottomNavigationBar: CustomBottomNavigationBar(
          controller: _controller,
          pageController: _pageController,
        ),
      ),
    );
  }
}
