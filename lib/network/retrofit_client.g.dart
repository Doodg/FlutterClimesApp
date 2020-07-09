// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RetrofitClient implements RetrofitClient {
  _RetrofitClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'http://api.openweathermap.org/data/2.5';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getWeather(lat, lon, {appKey = "13988052f5fcc853f82263ed18e7bab6"}) async {
    ArgumentError.checkNotNull(lat, 'lat');
    ArgumentError.checkNotNull(lon, 'lon');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lon': lon,
      r'appid': appKey
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/weather',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = WeatherMainResponse.fromJsonMap(_result.data);
    return value;
  }
}
