class Measurement {
  String end;
  String granularity;
  String groupId;
  String hostId;
  List<Links> links;
  List<Measurements> measurements;
  String processId;
  String start;

  Measurement(
      {this.end,
      this.granularity,
      this.groupId,
      this.hostId,
      this.links,
      this.measurements,
      this.processId,
      this.start});

  Measurement.fromJson(Map<String, dynamic> json) {
    end = json['end'];
    granularity = json['granularity'];
    groupId = json['groupId'];
    hostId = json['hostId'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    if (json['measurements'] != null) {
      measurements = [];
      json['measurements'].forEach((v) {
        measurements.add(new Measurements.fromJson(v));
      });
    }
    processId = json['processId'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end'] = this.end;
    data['granularity'] = this.granularity;
    data['groupId'] = this.groupId;
    data['hostId'] = this.hostId;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    if (this.measurements != null) {
      data['measurements'] = this.measurements.map((v) => v.toJson()).toList();
    }
    data['processId'] = this.processId;
    data['start'] = this.start;
    return data;
  }
}

class Links {
  String href;
  String rel;

  Links({this.href, this.rel});

  Links.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    rel = json['rel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['rel'] = this.rel;
    return data;
  }
}

class Measurements {
  List<DataPoints> dataPoints;
  String name;
  String units;

  Measurements({this.dataPoints, this.name, this.units});

  Measurements.fromJson(Map<String, dynamic> json) {
    if (json['dataPoints'] != null) {
      dataPoints = [];
      json['dataPoints'].forEach((v) {
        dataPoints.add(new DataPoints.fromJson(v));
      });
    }
    name = json['name'];
    units = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataPoints != null) {
      data['dataPoints'] = this.dataPoints.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['units'] = this.units;
    return data;
  }
}

class DataPoints {
  String timestamp;
  double value;

  DataPoints({this.timestamp, this.value});

  DataPoints.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['value'] = this.value;
    return data;
  }
}
