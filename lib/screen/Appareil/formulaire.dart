import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour le filtrage des entrées

class Formulaire extends StatefulWidget {
  const Formulaire({super.key});

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  String _selectedCategory = '';
  bool _isElectricitySelected = false;
  bool _isWaterSelected = false;
  String _moduleCount = '';
  String _numPrises = '';
  String _numPompes = '';
  String _errorMessage = '';
  int _prixFinal = 0;

  void _calculatePrice() {
    int basePrice = 0;
    int prisesPrice = 0;
    int pompesPrice = 0;

    // ---------- "Simple foyer" -----------------------
    if (_selectedCategory == 'Simple foyer') {
      //l'électricité
      if (_isElectricitySelected && !_isWaterSelected) {
        basePrice = 15000;
        int prisesCount = int.tryParse(_numPrises) ?? 0;
        prisesPrice = prisesCount > 8 ? 15000 + (prisesCount - 8) * 5000 : 0;
      }

      //l'eau
      else if (!_isElectricitySelected && _isWaterSelected) {
        basePrice = 15000;
        int pompesCount = int.tryParse(_numPompes) ?? 0;
        pompesPrice = pompesCount > 1 ? 15000 + (pompesCount - 1) * 6000 : 0;
      }

      //deux
      else if (_isElectricitySelected && _isWaterSelected) {
        basePrice = 20000;
        int prisesCount = int.tryParse(_numPrises) ?? 0;
        prisesPrice = prisesCount > 8 ? 15000 + (prisesCount - 8) * 5000 : 0;
        int pompesCount = int.tryParse(_numPompes) ?? 0;
        pompesPrice = pompesCount > 1 ? 15000 + (pompesCount - 1) * 6000 : 0;
      }
    }

    // ----------------------- "Entreprise" ------------------------------
    else if (_selectedCategory == 'Entreprise') {
      //l'électricité
      if (_isElectricitySelected && !_isWaterSelected) {
        basePrice = 400000;
        int prisesCount = int.tryParse(_numPrises) ?? 0;
        prisesPrice =
            prisesCount > 16 ? 400000 + (prisesCount - 16) * 15000 : 0;
      }

      //l'eau
      else if (!_isElectricitySelected && _isWaterSelected) {
        basePrice = 400000;
        int pompesCount = int.tryParse(_numPompes) ?? 0;
        pompesPrice = pompesCount > 1 ? 400000 + (pompesCount - 1) * 10000 : 0;
      }

      //deux
      else if (_isElectricitySelected && _isWaterSelected) {
        basePrice = 600000;
        int prisesCount = int.tryParse(_numPrises) ?? 0;
        prisesPrice =
            prisesCount > 16 ? 400000 + (prisesCount - 16) * 15000 : 0;
        int pompesCount = int.tryParse(_numPompes) ?? 0;
        pompesPrice = pompesCount > 1 ? 400000 + (pompesCount - 1) * 10000 : 0;
      }
    }

    // !mmmmmodules
    int modulesMultiplier = int.tryParse(_moduleCount) ?? 1;
    _prixFinal = (basePrice + prisesPrice + pompesPrice) * modulesMultiplier;
  }

  void _validateAndSubmit() {
    setState(() {
      _errorMessage = '';
      _prixFinal = 0;
    });

    // Validation des entrées
    if (_selectedCategory.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez sélectionner une catégorie d\'utilisateur.';
      });
      return;
    }

    if (_moduleCount.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer le nombre de modules.';
      });
      return;
    }

    if (_isElectricitySelected && _numPrises.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer le nombre de prises.';
      });
      return;
    }

    if (_isWaterSelected && _numPompes.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer le nombre de pompes.';
      });
      return;
    }

    // Calculer le prix final
    _calculatePrice();

    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0CDE92),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Catégorie d'utilisateur",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Simple foyer',
                        groupValue: _selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value ?? '';
                          });
                        },
                      ),
                      const Text("Simple foyer"),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: 'Entreprise',
                        groupValue: _selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value ?? '';
                          });
                        },
                      ),
                      const Text("Entreprise"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Type de modules",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isElectricitySelected,
                        onChanged: (bool? value) {
                          setState(() {
                            _isElectricitySelected = value ?? false;
                          });
                        },
                      ),
                      const Text("Électricité"),
                      const SizedBox(width: 20),
                      Checkbox(
                        value: _isWaterSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            _isWaterSelected = value ?? false;
                          });
                        },
                      ),
                      const Text("Eau"),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Nombre de modules",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      setState(() {
                        _moduleCount = value;
                      });
                    },
                  ),
                  if (_isElectricitySelected) ...[
                    const SizedBox(height: 20),
                    Text(
                      "Nombre de prises",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        setState(() {
                          _numPrises = value;
                        });
                      },
                    ),
                  ],
                  if (_isWaterSelected) ...[
                    const SizedBox(height: 20),
                    Text(
                      "Nombre de pompes",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: (value) {
                        setState(() {
                          _numPompes = value;
                        });
                      },
                    ),
                  ],
                  if (_errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                  if (_prixFinal > 0) ...[
                    const SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Prix final : $_prixFinal Ar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Payer par : ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              constraints: const BoxConstraints(
                                maxHeight: 130,
                                maxWidth: 250,
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/Images/orange.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _validateAndSubmit,
                      child: const Text('VALIDER'),
                    ),
                  ),
                ],
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
    );
  }
}
