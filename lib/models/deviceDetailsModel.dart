class DeviceDetails {
  String deviceID;
  String rssiValue;
  String localName;
  String blueToothType;
  Map manufacturerData;
  bool isDiscoveringServices;

  DeviceDetails({this.deviceID, this.rssiValue, this.localName, this.blueToothType, this.manufacturerData, this.isDiscoveringServices});

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    deviceID = json['deviceID'];
    rssiValue = json['rssiValue'];
    localName = json['localName'];
    blueToothType = json['blueToothType'];
    manufacturerData = json['manufacturerData'] != null ? Map.from(json['manufacturerData']) : null;
    isDiscoveringServices = json['isDiscoveringServices'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceID'] = this.deviceID;
    data['rssiValue'] = this.rssiValue;
    data['localName'] = this.localName;
    data['blueToothType'] = this.blueToothType;
    if (this.manufacturerData != null) {
      data['manufacturerData'] = this.manufacturerData;
    }
    data['isDiscoveringServices'] = this.isDiscoveringServices;
    return data;
  }
}
