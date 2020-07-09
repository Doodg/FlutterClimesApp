
class Sys {

  int type;
  int id;
  double message;
  String country;
  int sunrise;
  int sunset;

	Sys.fromJsonMap(Map<String, dynamic> map): 
		type = map["type"],
		id = map["id"],
		message = map["message"],
		country = map["country"],
		sunrise = map["sunrise"],
		sunset = map["sunset"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = type;
		data['id'] = id;
		data['message'] = message;
		data['country'] = country;
		data['sunrise'] = sunrise;
		data['sunset'] = sunset;
		return data;
	}
}
