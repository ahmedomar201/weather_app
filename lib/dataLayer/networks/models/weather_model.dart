class WeatherModel {
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  int? id;
  String? name;

  WeatherModel({this.weather, this.main, this.wind, this.id, this.name});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }

    main = json['main'] != null ? new Main.fromJson(json['main']) : null;

    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;

    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }

    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }

    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }

    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}

class Weather {
  int? id;
  String? main;

  Weather({this.id, this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;

    return data;
  }
}

class Main {
  double? temp;

  int? humidity;

  Main({this.temp, this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];

    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;

    data['humidity'] = this.humidity;

    return data;
  }
}

class Wind {
  double? speed;

  Wind({this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = speed;

    return data;
  }
}
