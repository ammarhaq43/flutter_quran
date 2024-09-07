import 'package:flutter/material.dart';
import 'package:flutter_quran/models/aya_of_the_day.dart';
import 'package:flutter_quran/services/api_services.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HijriCalendar _hijri = HijriCalendar.now();
  ApiServices _apiServices = ApiServices();
  void setData() async{
    //Obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", true);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  // Arabic month names map
  final Map<int, String> _arabicMonthNames = {
    1: 'محرم',
    2: 'صفر',
    3: 'ربيع الأول',
    4: 'ربيع الآخر',
    5: 'جمادى الأولى',
    6: 'جمادى الآخرة',
    7: 'رجب',
    8: 'شعبان',
    9: 'رمضان',
    10: 'شوال',
    11: 'ذو القعدة',
    12: 'ذو الحجة',
  };

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyyy');
    var formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: _size.height * 0.29, // 29 % of screen
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background_img.jpg'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatted, style: TextStyle(color: Colors.white, fontSize: 30),),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              _hijri.hDay.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              _arabicMonthNames[_hijri.hMonth] ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              '${_hijri.hYear} AH',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Column(
                    children: [
                      FutureBuilder<AyaOfTheDay>(
                          future: _apiServices.getAyaOfTheDay(),
                          builder: (context, snapshot){
                            switch(snapshot.connectionState){
                              case ConnectionState.none:
                              return Icon(Icons.sync_problem);
                              case ConnectionState.waiting:
                              case ConnectionState.active:
                                return CircularProgressIndicator();
                              case ConnectionState.done:
                                return Container(
                                  margin: EdgeInsets.all(16),
                                  padding: EdgeInsetsDirectional.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(0, 1)
                                      )
                                    ]
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Quran Aya of the Day", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18),),
                                      Divider(color: Colors.black, thickness: 0.5,),
                                      Text(snapshot.data!.arText!,
                                        style: TextStyle(color: Colors.black54,fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        snapshot.data!.enTran!,
                                        style: TextStyle(color: Colors.black54,fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      RichText (
                                          text: TextSpan(
                                              children: <InlineSpan>[
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(snapshot.data!.surNumber!.toString()
                                                    , style: TextStyle(fontSize: 16),),
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(snapshot.data!.surEnName!, style: TextStyle(fontSize: 16),),
                                                  ),
                                                ),
                                              ]
                                          )
                                      )
                                    ],
                                  ),
                                );
                            }
                          }
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
