import 'package:flutter/material.dart';
import 'package:oscapp/models/fetch_dataprovider.dart';
import 'package:provider/provider.dart';

class AchatScreen extends StatefulWidget {
  const AchatScreen({Key? key}) : super(key: key);

  @override
  State<AchatScreen> createState() => _AchatScreenState();
}

class _AchatScreenState extends State<AchatScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch device data when the screen is initialized
    Provider.of<FetchDataProvider>(context, listen: false).fetchDeviceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achat des Appareils'),
      ),
      body: Consumer<FetchDataProvider>(
        builder: (context, dataProvider, child) {
          // Check if data is being loaded
          if (dataProvider.deviceData.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          // Display the list of devices
          return ListView.builder(
            itemCount: dataProvider.deviceData.length,
            itemBuilder: (context, index) {
              var device = dataProvider.deviceData[index];

              return ListTile(
                leading: Image.network(device['url'], width: 50, height: 50),
                title: Text(device['nom']),
                subtitle: Text(device['type']),
              );
            },
          );
        },
      ),
    );
  }
}
