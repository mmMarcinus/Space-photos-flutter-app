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
  PFMR? pfmr_navcam;
  PFMR? pfmr_fhaz;
  PFMR? pfmr_rhaz;
  NasaAPI(@required this.date);

  String getAPODurl(DateTime dateUrl) {
    String dateString = "${dateUrl.year}-${dateUrl.month}-${dateUrl.day}";
    return Uri.encodeFull(
        'https://api.nasa.gov/planetary/apod?date=$dateString&hd=true&api_key=$api_key');
  }

  String getPFMRurl(String roverName, String camera) {
    return Uri.encodeFull(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/$roverName/photos?sol=1000&camera=$camera&api_key=$api_key');
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

  Future<void> getPFMRdata(String roverName) async {
    Uri urlNavcam = Uri.parse(getPFMRurl(roverName, 'navcam'));
    Uri urlFHAZ = Uri.parse(getPFMRurl(roverName, 'fhaz'));
    Uri urlRHAZ = Uri.parse(getPFMRurl(roverName, 'rhaz'));
    try {
      http.Response navcamResponse = await http.get(urlNavcam);
      data = navcamResponse.body;
      pfmr_navcam = PFMR.fromJson(convert.jsonDecode(data!));
      http.Response fhazResponse = await http.get(urlFHAZ);
      data = fhazResponse.body;
      pfmr_fhaz = PFMR.fromJson(convert.jsonDecode(data!));
      http.Response rhazResponse = await http.get(urlRHAZ);
      data = rhazResponse.body;
      pfmr_rhaz = PFMR.fromJson(convert.jsonDecode(data!));

      // print(pfmr!.photos.length);
      //print(pfmr_navcam!.photos);
      print(pfmr_fhaz!.photos);
      //print(pfmr_navcam!.photos);
    } catch (err) {
      print(err);
    }
  }
}
