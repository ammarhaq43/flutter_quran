import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  Location location = new Location();
  LocationData? _currentPosition;
  double? latitude, longitude;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Prayer Timings', style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xff8951cf),
          ),
          body: FutureBuilder(
              future: getLoc(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Constants.kPrimary,
                    ),
                  );
                }
                final myCoordinates = Coordinates(24.8607, 67.0011);  //Replace with your own location lat, lang
                final params = CalculationMethod.karachi.getParameters();
                params.madhab = Madhab.hanafi;
                final prayerTimes = PrayerTimes.today(myCoordinates, params);

                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fajr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(DateFormat.jm().format(prayerTimes.fajr),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black, thickness: 1,),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Text('Sunrise', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            Text(DateFormat.jm().format(prayerTimes.sunrise),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black, thickness: 1,),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dhuhr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(DateFormat.jm().format(prayerTimes.dhuhr),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,thickness: 1,),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Asr', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(DateFormat.jm().format(prayerTimes.asr),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,thickness: 1,),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Maghrib', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(DateFormat.jm().format(prayerTimes.maghrib),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.black,thickness: 1,),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Isha', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(DateFormat.jm().format(prayerTimes.isha),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        )
    );
  }

  getLoc() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;


    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return;
      }
    }
    _currentPosition = await location.getLocation();
    latitude = _currentPosition!.latitude!;
    longitude = _currentPosition!.longitude!;
  }
}

