import 'package:flutter/material.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'package:provider/provider.dart';

class Magasinliste extends StatefulWidget {
  const Magasinliste({super.key});

  @override
  State<Magasinliste> createState() => _MagasinlisteState();
}

class _MagasinlisteState extends State<Magasinliste> {
  @override
  void initState() {
    super.initState();
    // Fetch shops when the widget is initialized
    Future.delayed(Duration.zero, () {
      Provider.of<FetchDataProvider>(context, listen: false).fetchShops();
    });
  }

  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<FetchDataProvider>(context).shops;

    return Expanded(
      child: ListView.builder(
        itemCount: shops.length,
        itemBuilder: (context, index) {
          final shop = shops[index];

          return GestureDetector(
            onTap: () {
              _showShopDetailsDialog(context, shop);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              margin: const EdgeInsets.only(bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
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
                        child: shop['image'] != null
                            ? Image.network(
                                shop['url'],
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.shopping_cart,
                                size: 25,
                                color: Color(0xFF36C18B),
                              ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop['nom'] ?? 'Inconnu',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Nous sommes disponibes pour vos materiel",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                width: 125,
                                child: Text(
                                  'Située à ${shop['quartier'] ?? 'Inconnu'}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_horiz_rounded,
                    size: 25,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showShopDetailsDialog(BuildContext context, Map shop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(shop['nom'] ?? 'Inconnu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              shop['url'] != null
                  ? Image.network(
                      shop['url'],
                      height: 100,
                      fit: BoxFit.contain,
                    )
                  : const Icon(
                      Icons.shopping_cart,
                      size: 50,
                      color: Color(0xFF36C18B),
                    ),
              const SizedBox(height: 35),
              Text('Téléphone: ${shop['telephone'] ?? 'Inconnu'}'),
              const SizedBox(height: 10),
              Text('Quartier : ${shop['quartier'] ?? 'Inconnu'}'),
              const SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
