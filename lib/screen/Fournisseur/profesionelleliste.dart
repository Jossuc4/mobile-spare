import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Ajoutez cette ligne pour utiliser url_launcher
import 'package:provider/provider.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';

class Profesionelleliste extends StatefulWidget {
  const Profesionelleliste({super.key});

  @override
  State<Profesionelleliste> createState() => _ProfesionellelisteState();
}

class _ProfesionellelisteState extends State<Profesionelleliste> {
  @override
  void initState() {
    super.initState();
    // Fetch pro data when the screen is initialized
    Future.microtask(() =>
        Provider.of<FetchDataProvider>(context, listen: false).fetchProData());
  }

  // Fonction pour afficher les détails d'un expert dans un dialogue
  void _showExpertDetails(
      BuildContext context, Map<String, dynamic> expert) async {
    // Fonction pour lancer l'appel
    Future<void> _launchCaller(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Impossible de lancer $phoneNumber';
      }
    }

    // Fonction pour lancer l'email
    Future<void> _launchEmail(String email) async {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Impossible d\'envoyer un email à $email';
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(expert['nom']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                expert['url'],
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text("Profession: ${expert['profession']}"),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () =>
                        _launchCaller(expert['telephone']), // Appel
                  ),
                  const SizedBox(width: 8),
                  Text(expert['telephone']),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.email, color: Colors.blue),
                    onPressed: () => _launchEmail(expert['mail']), // Email
                  ),
                  const SizedBox(width: 8),
                  Text(expert['mail']),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 10),
              Text("Quartier: ${expert['quartier']}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Accès aux données des experts via le provider
    final proData = Provider.of<FetchDataProvider>(context).proData;

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        itemCount:
            proData.length, // Nombre dynamique basé sur la longueur des données
        itemBuilder: (context, index) {
          final pro = proData[index]; // Accéder à un élément spécifique

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWell(
              onTap: () => _showExpertDetails(
                  context, pro), // Afficher les détails à la sélection
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
                        child: Image.network(
                          pro['url'], // Charger l'image depuis l'URL
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 30,
                              color: Color(0xFF36C18B),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 235,
                            child: Text(
                              pro['nom'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 175,
                            child: Text(
                              "${pro['profession']} se trouve autour de ${pro['quartier']}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
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
}
