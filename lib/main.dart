import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:hypervolt_code/detailsScreen.dart';
import 'package:hypervolt_code/models/deviceDetailsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperVolt Challenge App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeviceScanPage(),
    );
  }
}

class DeviceScanPage extends StatefulWidget {
  @override
  _DeviceScanPageState createState() => _DeviceScanPageState();
}

class _DeviceScanPageState extends State<DeviceScanPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan For BLE Devices"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: flutterBlue.startScan(scanMode: ScanMode.lowLatency),
          builder: (context, future) {
            return StreamBuilder<List<ScanResult>>(
                stream: flutterBlue.scanResults,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            print(snapshot.data[index]);
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                              deviceDetails: DeviceDetails.fromJson({
                                                "deviceID": snapshot.data[index].device.id.id,
                                                "rssiValue": snapshot.data[index].rssi.toString(),
                                                "localName": snapshot.data[index].device.name != "" ? snapshot.data[index].device.name : snapshot.data[index].device.id.id,
                                                "blueToothType": snapshot.data[index].device.type.toString(),
                                                "manufacturerData": snapshot.data[index].advertisementData.manufacturerData,
                                                "isDiscoveringServices": snapshot.data[index].advertisementData.connectable
                                              }),
                                            )));
                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: getIcon(snapshot.data[index].device.type),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data[index].device.name != "" ? snapshot.data[index].device.name : snapshot.data[index].device.id.id),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: getTrailingText(snapshot.data[index].rssi),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        )
                      : CircularProgressIndicator();
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_sharp),
        onPressed: () async {
          await flutterBlue.stopScan();
          setState(() {});
        },
      ),
    );
  }

  getIcon(BluetoothDeviceType type) {
    if (type == BluetoothDeviceType.le) {
      return Icon(Icons.bluetooth_audio_outlined);
    } else if (type == BluetoothDeviceType.classic) {
      return Icon(Icons.smartphone_rounded);
    } else if (type == BluetoothDeviceType.dual) {
      return Icon(Icons.phone_bluetooth_speaker);
    } else {
      return Icon(Icons.bluetooth_rounded);
    }
  }

  getTrailingText([int rssi]) {
    if (rssi > -50) {
      return Text("Signal Strength: Excellent");
    } else if (rssi < -50 && rssi > -60) {
      return Text("Signal Strength: Good");
    } else if (rssi < -60 && rssi > -70) {
      return Text("Signal Strength: Fair");
    } else {
      return Text("Signal Strength: Weak");
    }
  }
}
