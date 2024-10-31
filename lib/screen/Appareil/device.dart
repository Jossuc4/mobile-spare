import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oscapp/models/data_storage.dart';
import 'package:oscapp/models/socket_provider.dart';
import 'package:oscapp/screen/Appareil/toggle.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DeviceGrid extends StatelessWidget {
  final String filter;

  const DeviceGrid({super.key, required this.filter});

  // Fonction pour envoyer les états à l'API
  Future<void> _postDeviceStates(Map<String, dynamic> deviceStates) async {
    final url = Uri.parse('http://34.238.235.206/iot/publish');
    final body = json.encode({
      "state": {
        "desired": {
          ...deviceStates, // Utilise les états des relais actuels
          "welcome": "aws-iot" // Inclure toujours ce message
        }
      }
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print("Post réussi: ${response.body}");
      } else {
        print("Erreur lors du POST: ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur de connexion : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(
      builder: (context, socketProvider, child) {
        final deviceStates =
            json.decode(socketProvider.stateData) as Map<String, dynamic>;

        print(
            'State Data dans Appareil Screen : $deviceStates'); // Imprimer les états actuels

        List<Widget> filteredDevices = [];

        for (int i = 1; i <= deviceStates.length; i++) {
          bool isOn = (deviceStates['relay_$i'] == 1);

          switch (filter) {
            case 'All':
              filteredDevices.add(DeviceToggle(
                deviceName: "Device $i",
                isOn: isOn,
                onToggle: (newState) {
                  // Mise à jour de l'état local
                  Map<String, dynamic> updatedStates = Map.from(deviceStates);
                  updatedStates['relay_$i'] = newState ? 1 : 0;

                  // Imprimer l'état changé
                  print(
                      'Changement effectué sur Device $i: ${newState ? "ON" : "OFF"}');
                  print('Nouveaux états des relais : $updatedStates');

                  // Envoyer les états mis à jour à l'API
                  _postDeviceStates(updatedStates);

                  // Mettre à jour l'état dans le provider
                  socketProvider.updateStateData(
                      updatedStates, context.read<DataStorage>());
                },
              ));
              break;
            case 'On':
              if (isOn) {
                filteredDevices.add(DeviceToggle(
                  deviceName: "Device $i",
                  isOn: isOn,
                  onToggle: (newState) {
                    // Mise à jour de l'état local
                    Map<String, dynamic> updatedStates = Map.from(deviceStates);
                    updatedStates['relay_$i'] = newState ? 1 : 0;

                    // Imprimer l'état changé
                    print(
                        'Changement effectué sur Device $i: ${newState ? "ON" : "OFF"}');
                    print('Nouveaux états des relais : $updatedStates');

                    // Envoyer les états mis à jour à l'API
                    _postDeviceStates(updatedStates);

                    // Mettre à jour l'état dans le provider
                    socketProvider.updateStateData(
                        updatedStates, context.read<DataStorage>());
                  },
                ));
              }
              break;
            case 'Off':
              if (!isOn) {
                filteredDevices.add(DeviceToggle(
                  deviceName: "Device $i",
                  isOn: isOn,
                  onToggle: (newState) {
                    // Mise à jour de l'état local
                    Map<String, dynamic> updatedStates = Map.from(deviceStates);
                    updatedStates['relay_$i'] = newState ? 1 : 0;

                    // Imprimer l'état changé
                    print(
                        'Changement effectué sur Device $i: ${newState ? "ON" : "OFF"}');
                    print('Nouveaux états des relais : $updatedStates');

                    // Envoyer les états mis à jour à l'API
                    _postDeviceStates(updatedStates);

                    // Mettre à jour l'état dans le provider
                    socketProvider.updateStateData(
                        updatedStates, context.read<DataStorage>());
                  },
                ));
              }
              break;
          }
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            mainAxisSpacing: 35,
          ),
          itemCount: filteredDevices.length,
          itemBuilder: (context, index) {
            return filteredDevices[index];
          },
        );
      },
    );
  }
}
