import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'data_storage.dart'; // Import the new file

class FetchDataProvider with ChangeNotifier {
  List _shops = [];
  Map<String, dynamic> _stateData = {};
  List _proData = []; // List to store the data from the 'pro' API
  List _deviceData = []; // List to store the data from the 'device' API
  List _notifications = []; // List to store the notifications data
  DataStorage _dataStorage = DataStorage(); // Create an instance of DataStorage
  double _statHour = 0.0; // Variable to store the number from 'stat/hour'

  List get shops => _shops;
  Map<String, dynamic> get stateData => _stateData;
  List get proData => _proData; // Getter for the proData
  List get deviceData => _deviceData; // Getter for the deviceData
  List get notifications => _notifications; // Getter for notifications data
  Map<String, dynamic> get dataFinals =>
      _dataStorage.dataFinals; // Use dataFinals from DataStorage
  double get statHour => _statHour; // Getter for the statHour data

  // Fetch data from the shops API
  Future<void> fetchShops() async {
    final response =
        await http.get(Uri.parse('http://34.238.235.206/shops/all'));
    if (response.statusCode == 200) {
      _shops = json.decode(response.body);
      print("Number of shops fetched: ${_shops.length}");
      notifyListeners();
    } else {
      print("Failed to load shops");
    }
  }

  // Fetch data from the pro API
  Future<void> fetchProData() async {
    final response = await http.get(Uri.parse('http://34.238.235.206/pro/all'));
    if (response.statusCode == 200) {
      _proData = json.decode(response.body);
      print("Number of pro data fetched: ${_proData.length}");
      notifyListeners();
    } else {
      print("Failed to load pro data");
    }
  }

  // Fetch data from the device API
  Future<void> fetchDeviceData() async {
    final response =
        await http.get(Uri.parse('http://34.238.235.206/device/all'));
    if (response.statusCode == 200) {
      _deviceData = json.decode(response.body);
      print("Number of devices fetched: ${_deviceData.length}");
      notifyListeners();
    } else {
      print("Failed to load device data");
    }
  }

  // Fetch data from the notification API
  Future<void> fetchNotifications() async {
    final response =
        await http.get(Uri.parse('http://34.238.235.206/notification/getall'));
    if (response.statusCode == 200) {
      _notifications = json.decode(response.body);
      print("Number of notifications fetched: ${_notifications.length}");
      notifyListeners();
    } else {
      print("Failed to load notifications");
    }
  }
}
