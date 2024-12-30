import 'package:flutter/material.dart';
import 'package:oscapp/screen/Appareil/device.dart';
import 'package:oscapp/screen/Appareil/filter.dart';
import 'package:oscapp/screen/Appareil/formulaire.dart';
import 'package:oscapp/screen/Appareil/resume.dart';
import 'package:oscapp/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class AppareilScreen extends StatefulWidget {
  final bool isDrawerVisible;

  const AppareilScreen({
    super.key,
    required this.isDrawerVisible,
  });

  @override
  State<AppareilScreen> createState() => _AppareilScreenState();
}

class _AppareilScreenState extends State<AppareilScreen> {
  String _selectedFilter = 'All';

  void _updateFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Commander des modules'),
          content: const Text(
              'Vous allez être redirigé vers le site pour commander des modules.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.grey,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "Devices",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                /*Positioned(
                  top: -10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    color: isDarkMode ? Colors.white : Colors.grey[600],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Formulaire()));
                    },
                  ),
                ),*/
              ],
            ),
            const SizedBox(height: 20),
            ResumeAll(),
            const SizedBox(height: 20),
            FilterButtons(updateFilter: _updateFilter),
            const SizedBox(height: 20),
            DeviceGrid(filter: _selectedFilter),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
