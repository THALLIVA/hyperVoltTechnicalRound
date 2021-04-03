import 'package:flutter/material.dart';
import 'package:hypervolt_code/models/deviceDetailsModel.dart';

class DetailsScreen extends StatefulWidget {
  final DeviceDetails deviceDetails;

  DetailsScreen({this.deviceDetails});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Details"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text("Device Mac ID"),
              subtitle: Text(widget.deviceDetails.deviceID),
            ),
            ListTile(
              title: Text("Device Local Name"),
              subtitle: Text(widget.deviceDetails.localName),
            ),
            ListTile(
              title: Text("Device Manufacture Data"),
              subtitle: Text(widget.deviceDetails.manufacturerData.toString()),
            ),
            ListTile(
              title: Text("Device RSSI Value"),
              subtitle: Text(widget.deviceDetails.rssiValue),
            ),
            ListTile(
              title: Text("Is Device Discovering Services"),
              subtitle: Text(widget.deviceDetails.isDiscoveringServices ? "Yes" : "No"),
            ),
          ],
        ),
      ),
    );
  }
}
