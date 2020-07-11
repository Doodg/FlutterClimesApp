import 'package:climes_app/model/weather_main_response.dart';
import 'package:climes_app/network/retrofit_client.dart';
import 'package:climes_app/ui/weather_item.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../l10n/s.dart';

class HomePage extends StatefulWidget {
  final bool androidFusedLocation = true;

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).AppName),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  _initCurrentLocation();
                },
                child: Icon(Icons.refresh),
              ),
            ),
          ],
        ),
        body: FutureBuilder<GeolocationStatus>(
          future: Geolocator().checkGeolocationPermissionStatus(),
          builder: (BuildContext context,
              AsyncSnapshot<GeolocationStatus> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == GeolocationStatus.denied) {
              return Center(
                child: Container(
                  child: Text(
                    'Access to location denied Allow access to the location services for this App using the device settings.',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              );
            }
            if (snapshot.data == GeolocationStatus.granted) {
              return Container(
                child: FutureBuilder<WeatherMainResponse>(
                    future: Provider.of<RetrofitClient>(context, listen: false)
                        .getWeather(_currentPosition?.latitude.toString() ?? "",
                            _currentPosition?.longitude.toString() ?? ""),
                    builder:
                        (context, AsyncSnapshot<WeatherMainResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return Container(
                            child: WeatherWidget(snapshot.data, context),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.hasError);
                          return Container(
                            child: Center(
                              child: Text("Reading from the sky...."),
                            ),
                          );
                        } else {
                          return Container(
                            child: Text("Something went wrong.."),
                          );
                        }
                      }
                    }),
              );
            }

            return Container(
              child: Text("loading..."),
            );
          },
        ));
  }

  void _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).then((position) {
        if (mounted) {
          setState(() => _currentPosition = position);
        }
      }).catchError((e) {
        //
      });
  }
}

class WeatherWidget extends StatelessWidget {
  WeatherMainResponse _weatherMainResponse;
  BuildContext _context;

  WeatherWidget(this._weatherMainResponse, this._context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WeatherItem(
                  itemTitle: S.of(_context).Location,
                  itemValue: _weatherMainResponse.name,
                  itemIcon: Icons.gps_fixed,
                )),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WeatherItem(
                  itemTitle: S.of(_context).Temp,
                  itemValue:
                      "${_weatherMainResponse.weatherDetails.temp.convertFromKelvinToCel}${S.of(context).CelsiusMark}",
                  itemIcon: Icons.wb_sunny,
                )),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WeatherItem(
                  itemTitle: S.of(_context).FeelLike,
                  itemValue:
                      "${_weatherMainResponse.weatherDetails.feels_like.convertFromKelvinToCel}${S.of(context).CelsiusMark}",
                  itemIcon: Icons.supervised_user_circle,
                )),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WeatherItem(
                  itemTitle: S.of(_context).Humidity,
                  itemValue: "${_weatherMainResponse.weatherDetails.humidity}%",
                  itemIcon: Icons.cloud,
                )),
            Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: WeatherItem(
                  itemTitle: S.of(_context).Wind,
                  itemValue: "${_weatherMainResponse.wind.speed}M/S",
                  itemIcon: Icons.track_changes,
                ))
          ],
        ),
      ),
    ));
  }
}

extension on int {
  get fromMilliSecondsToDate {
    return new DateTime.fromMillisecondsSinceEpoch(this * 1000);
  }
}

extension on double {
  get convertFromKelvinToCel {
    return (this - 273.15).round();
  }
}
