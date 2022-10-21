import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:space_pictures_app/models/apodModel.dart';
import 'dart:convert' as convert;

import 'package:space_pictures_app/models/pfmrModel.dart';

class NasaAPI extends ChangeNotifier {
  final DateTime date;
  String api_key = '4bE1a2gX0mqeXS8EX1htqGgH5cyH5lECsbAczZ2B';
  String? data;
  Apod? apod;
  PFMR? pfmr;
  NasaAPI(@required this.date);

  String getAPODurl(DateTime dateUrl) {
    String dateString = "${dateUrl.year}-${dateUrl.month}-${dateUrl.day}";
    return Uri.encodeFull(
        'https://api.nasa.gov/planetary/apod?date=$dateString&hd=true&api_key=$api_key');
  }

  String getPFMRurl() {
    return Uri.encodeFull(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=$api_key');
  }

  Future<void> getAPODdata(DateTime dateApod) async {
    Uri url = Uri.parse(getAPODurl(dateApod));
    try {
      http.Response response = await http.get(url);
      data = response.body;
      apod = Apod.fromJson(convert.jsonDecode(data!));
    } catch (err) {
      print(err);
    }
    //await Future.delayed(Duration(milliseconds: 1500));
  }

  Future<void> getPFMRdata() async {
    Uri url = Uri.parse(getPFMRurl());
    try {
      http.Response response = await http.get(url);
      data = response.body;
      pfmr = PFMR.fromJson(convert.jsonDecode(data!));
      // print(pfmr!.photos.length);
      // print(pfmr!.photos[2]['img_src']);
    } catch (err) {
      print(err);
    }
  }
}
