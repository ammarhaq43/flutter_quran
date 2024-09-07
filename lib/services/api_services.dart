import 'dart:convert';
import 'dart:math';
import 'package:flutter_quran/models/juz.dart';
import 'package:flutter_quran/models/translation.dart';
import 'package:flutter_quran/ui/surah_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_quran/models/aya_of_the_day.dart';
import '../models/sajda.dart';
import '../models/surah.dart';

class ApiServices {
  final String endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<Surah> list = [];

  // Generate a random number within a range
  int random(int min, int max) {
    var rn = Random();
    return min + rn.nextInt(max - min + 1); // Ensure max is inclusive
  }

  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url = "https://api.alquran.cloud/v1/ayah/${random(
        1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to load post");
    }
  }

  Future<List<Surah>> getSurah() async {
    final response = await http.get(Uri.parse(endPointUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      json['data'].forEach((element) {
        if (list.length < 114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('Total Surahs: ${list.length}');
      return list;
    } else {
      throw Exception("Can't get the Surah");
    }
  }

  Future<SajdaList> getSajda() async {
    String url = "http://api.alquran.cloud/v1/sajda/en.asad";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return SajdaList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed to load post");
    }
  }

  Future<SurahTranslationList> getTranslation(int index,
      int translationIndex) async {
    String lan = "";
    if (translationIndex == 0) {
      lan = "urdu_junagarhi";
    } else if (translationIndex == 1) {
      lan = "hindi_omari";
    } else if (translationIndex == 2) {
      lan = "english_saheeh";
    } else if (translationIndex == 3) {
      lan = "spanish_garcia";
    }

    final url = "https://quranenc.com/api/translation/sura/$lan/$index";
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return SurahTranslationList.fromJson(json.decode(res.body));
    } else {
      throw Exception("Failed to load translation");
    }
  }
}