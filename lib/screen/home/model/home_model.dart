class HomeModel {
  int? id, visibility, dt, timezone, cod;
  String? base, name;
  CoordModel? coordModel;
  List<WeatherModel>? weatherList;
  MainModel? mainModel;
  WindModel? windModel;
  CloudsModel? cloudsModel;
  SysModel? sysModel;

  HomeModel(
      {this.id,
        this.visibility,
        this.dt,
        this.timezone,
        this.cod,
        this.base,
        this.name,
        this.coordModel,
        this.weatherList,
        this.mainModel,
        this.windModel,
        this.cloudsModel,
        this.sysModel});

  factory HomeModel.mapToModel(Map m1) {
    List l1 = m1['weather'];
    return HomeModel(
      visibility: m1['visibility'],
      dt: m1['dt'],
      timezone: m1['timezone'],
      cod: m1['cod'],
      id: m1['id'],
      base: m1['base'],
      name: m1['name'],
      coordModel: CoordModel.mapToModel(m1['coord']),
      weatherList: l1.map((e) => WeatherModel.mapToModel(e)).toList(),
      mainModel: MainModel.mapToModel(m1['main']),
      windModel: WindModel.mapToModel(m1['wind']),
      cloudsModel: CloudsModel.mapToModel(m1['clouds']),
      sysModel: SysModel.mapToModel(m1['sys']),
    );
  }
}
class MainModel {
  double? temp, feels_like, temp_min, temp_max;
  int? pressure, humidity,timezone;

  MainModel(
      {this.temp,
        this.feels_like,
        this.temp_min,
        this.temp_max,
        this.pressure,
        this.humidity});

  factory MainModel.mapToModel(Map m1) {
    return MainModel(
        temp: m1['temp'],
        feels_like: m1['feels_like'],
        humidity: m1['humidity'],
        pressure: m1['pressure'],
        temp_max: m1['temp_max'],
        temp_min: m1['temp_min'],
    );
  }
}

class WeatherModel {
  int? id;
  String? main, description, icon;

  WeatherModel({this.id, this.main, this.description, this.icon});

  factory WeatherModel.mapToModel(Map m1) {
    return WeatherModel(
      id: m1['id'],
      main: m1['main'],
      description: m1['description'],
      icon: m1['icon'],
    );
  }
}

class CoordModel {
  double? lon, lat;

  CoordModel({this.lon, this.lat});
  factory CoordModel.mapToModel(Map m1) {
    return CoordModel(lon: m1['lon'], lat: m1['lat']);
  }
}

class SysModel {
  int? sunrise, sunset, type, id;
  String? country;

  SysModel({this.sunrise, this.sunset, this.country, this.type, this.id});

  factory SysModel.mapToModel(Map m1) {
    return SysModel(
      sunrise: m1['sunrise'],
      sunset: m1['sunset'],
      country: m1['country'],
      type: m1['type'],
      id: m1['id'],
    );
  }
}

class CloudsModel {
  int? all;

  CloudsModel({this.all});

  factory CloudsModel.mapToModel(Map m1) {
    return CloudsModel(all: m1['all']);
  }
}

class WindModel {
  double? speed;
  int? deg;

  WindModel({this.speed, this.deg});

  factory WindModel.mapToModel(Map m1) {
    return WindModel(
      speed: m1['speed'],
      deg: m1['deg'],
    );
  }
}