class HomeModel {
  String?  name;
  MainModel? mainModel;
  CoordModel? coordModel;

  HomeModel({this.name,this.coordModel,this.mainModel});

  factory HomeModel.mapToModel(Map m1)
  {
    return HomeModel(
      name: m1['name'],
      coordModel: CoordModel.mapToModel(m1['coord']),
      mainModel: MainModel.mapToModel(m1['main']),
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
        this.humidity,
      this.timezone});

  factory MainModel.mapToModel(Map m1) {
    return MainModel(
        temp: m1['temp'],
        feels_like: m1['feels_like'],
        humidity: m1['humidity'],
        pressure: m1['pressure'],
        temp_max: m1['temp_max'],
        temp_min: m1['temp_min'],
        timezone: m1['timezone'],
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