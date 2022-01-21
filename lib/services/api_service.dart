import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:majootestcase/models/movie_response.dart';
import 'package:majootestcase/services/dio_config_service.dart' as dioConfig;

class ApiServices{

  Future<MovieResponse> getMovieList() async {
    try {
      var dio = await dioConfig.dio();
      Response<String> response  = await dio.get("");
      MovieResponse movieResponse = MovieResponse.fromJson(jsonDecode(response.data!));
      return movieResponse;
    } catch(e) {
      print(e.toString());
      try {
        return MovieResponseFailure(msg: e.toString());
      } catch (e) {
        return MovieResponseFailure(msg: "an error occured");
      }
    }
  }
}