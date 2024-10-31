import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oscapp/models/data_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:oscapp/utils/notification_service.dart'; // Adjust the import according to your project structure

class SocketProvider with ChangeNotifier {
  late IO.Socket _socket;
  String _vitesseData = 'Waiting for vitesse data...';
  String _consommationData = 'Waiting for consommation data...';
  String _heure = 'Waiting for heure data...';
  String _stateData = json.encode({
    'relay_1': 0, // Default simulated state for device 1
    'relay_2': 0,
    'relay_3': 0,
    'relay_4': 0,
    'relay_5': 0, // Default simulated state for device 2
    'relay_6': 0,
    'relay_7': 0,
    'relay_8': 0,
  });
  bool _isConnected = false;
  String _frequence = "Waiting for frequence data ...";
  String _facteur_puissance = "Waiting for frequence data ...";

  SocketProvider(DataStorage dataStorage) {
    _initializeSocket(dataStorage);
    _fetchInitialStateData(); // Fetch initial state data from the API
  }

  void _initializeSocket(DataStorage dataStorage) {
    _socket = IO.io('http://34.238.235.206:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    // Connexion établie
    _socket.onConnect((_) {
      print('Connected to WebSocket server');
      _isConnected = true;
      notifyListeners();

      // Réception des données de l'état
      _socket.on('state', (data) {
        if (data is Map<String, dynamic>) {
          updateStateData(data, dataStorage);
        } else if (data is String) {
          try {
            Map<String, dynamic> stateData = json.decode(data);
            updateStateData(stateData, dataStorage);
          } catch (e) {
            print('Error while processing state data (String): $e');
          }
        } else {
          print('Received state data is not a recognized format: $data');
        }
      });
    });

    // Gestion des déconnexions
    _socket.onDisconnect((_) {
      print('Disconnected from WebSocket');
      _isConnected = false;
      notifyListeners();
    });

    // Gestion des erreurs de connexion
    _socket.onConnectError((data) {
      print('Connection error: $data');
    });

    // Gestion des erreurs
    _socket.onError((data) {
      print('Error: $data');
    });

    // Gestion des notifications
    _socket.on('notification', (data) {
      if (data is String) {
        try {
          Map<String, dynamic> notificationData = json.decode(data);
          String titre = notificationData['titre'] ?? 'No title';
          String subject = notificationData['subject'] ?? 'No subject';

          // Affiche le titre et le sujet dans le terminal
          print(
              '----------- Notification reçue - Titre: $titre, Subject: $subject');

          // Montre la notification
          NotificationService.showNotification(
            title: titre,
            body: subject,
          );
        } catch (e) {
          print('Error while processing notification: $e');
        }
      } else {
        print('Received data is not a String: $data');
      }
    });

    // Réception des données de vitesse
    _socket.on('vitesse', (data) {
      _vitesseData = data.toString();
      print('Vitesse data: $_vitesseData');
      notifyListeners();
    });

    // Réception des données de consommation
    _socket.on('consommation', (data) {
      _consommationData = data.toString();
      print('Consommation data: $_consommationData');
      notifyListeners();
    });

    _socket.on('hours', (data) {
      _heure = data.toString();
      print('heure data: $_heure');
      notifyListeners();
    });

    _socket.on('frequence', (data) {
      _frequence = data.toString();
      print('fréquence data: $_frequence');
      notifyListeners();
    });

    _socket.on('facteur-puissance', (data) {
      _facteur_puissance = data.toString();
      print('facteur de puissance data: $_facteur_puissance ');
      notifyListeners();
    });
  }

  Future<void> _fetchInitialStateData() async {
    try {
      final response = await http.get(Uri.parse('http://34.238.235.206/state'));
      if (response.statusCode == 200) {
        Map<String, dynamic> stateData = json.decode(response.body);
        updateStateData(stateData,
            DataStorage()); // Replace with your actual DataStorage instance
      } else {
        print('Failed to load state data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching initial state data: $e');
    }
  }

  void updateStateData(
      Map<String, dynamic> stateData, DataStorage dataStorage) {
    _stateData = json.encode(stateData);
    print(
        '\n \n \n**************************** State data updated: $_stateData ****************************');
    dataStorage.updateDataFinals(stateData);
    notifyListeners();
  }

  // Getters
  bool get isConnected => _isConnected;
  String get vitesseData => _vitesseData;
  String get consommationData => _consommationData;
  String get stateData => _stateData;
  String get heure => _heure;
  String get frequence => _frequence;
  String get facteur_puissance => _facteur_puissance;
  // Socket cleanup
  void disposeSocket() {
    _socket.dispose();
  }
}
