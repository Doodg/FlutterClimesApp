
class Wind {

  double speed;
  double deg;

	Wind.fromJsonMap(Map<String, dynamic> map): 
		speed = map["speed"].toDouble(),
		deg = map["deg"].toDouble();

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['speed'] = speed;
		data['deg'] = deg;
		return data;
	}
}
