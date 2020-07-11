import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../model/weather_main_response.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: "http://api.openweathermap.org/data/2.5")
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  static RetrofitClient create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return RetrofitClient(dio);
  }

  @GET("/weather")
  Future<WeatherMainResponse> getWeather(
      @Query("lat") String lat, @Query("lon") String lon,
      {@Query("appid") String appKey = "Add your key"});
}
