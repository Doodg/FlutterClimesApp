import 'package:climes_app/model/coord.dart';
import 'package:climes_app/model/weather.dart';
import 'package:climes_app/model/weather_details.dart';
import 'package:climes_app/model/wind.dart';
import 'package:climes_app/model/clouds.dart';
import 'package:climes_app/model/sys.dart';
import 'package:json_annotation/json_annotation.dart';

class WeatherMainResponse {

  Coord coord;
  List<Weather> weather;
  String base;
  @JsonKey(name: "main")
	WeatherDetails weatherDetails;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

	WeatherMainResponse.fromJsonMap(Map<String, dynamic> map): 
		coord = Coord.fromJsonMap(map["coord"]),
		weather = List<Weather>.from(map["weather"].map((it) => Weather.fromJsonMap(it))),
		base = map["base"],
				weatherDetails = WeatherDetails.fromJsonMap(map["main"]),
		wind = Wind.fromJsonMap(map["wind"]),
		clouds = Clouds.fromJsonMap(map["clouds"]),
		dt = map["dt"],
		sys = Sys.fromJsonMap(map["sys"]),
		timezone = map["timezone"],
		id = map["id"],
		name = map["name"],
		cod = map["cod"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['coord'] = coord == null ? null : coord.toJson();
		data['weather'] = weather != null ? 
			this.weather.map((v) => v.toJson()).toList()
			: null;
		data['base'] = base;
		data['main'] = weatherDetails == null ? null : weatherDetails.toJson();
		data['wind'] = wind == null ? null : wind.toJson();
		data['clouds'] = clouds == null ? null : clouds.toJson();
		data['dt'] = dt;
		data['sys'] = sys == null ? null : sys.toJson();
		data['timezone'] = timezone;
		data['id'] = id;
		data['name'] = name;
		data['cod'] = cod;
		return data;
	}
}
