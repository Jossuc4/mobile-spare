import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class DataStorage extends ChangeNotifier {
  // Extend ChangeNotifier
  Map<String, dynamic> _dataFinals = {};

  Map<String, dynamic> get dataFinals => _dataFinals;

  // Method to update _dataFinals with the new state data
  void updateDataFinals(Map<String, dynamic> stateData) {
    _dataFinals = stateData;
    print(
        "############### _dataFinals updated: $_dataFinals ###############################");
    notifyListeners(); // Notify listeners of the change
  }

  // Optionally, you can fetch state data here as well
  Future<void> fetchStateData() async {
    final response = await http.get(Uri.parse('http://34.238.235.206/state'));
    if (response.statusCode == 200) {
      _dataFinals = json.decode(response.body);
      print(
          "############### State data fetched: $_dataFinals ###############################");
      notifyListeners(); // Notify listeners of the change
    } else {
      print("Failed to load state data");
    }
  }
}
