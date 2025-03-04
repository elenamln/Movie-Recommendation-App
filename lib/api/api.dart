import 'package:my_movie_app/api/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_movie_app/model/move.model.dart';

class Api {
  final upcomingApiUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final topRatedApiUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";

Future<List<Movie>> getUpcomingMovies() async {
  final response = await http.get(Uri.parse(upcomingApiUrl));

  if(response.statusCode == 200){
    final List<dynamic> data = json.decode(response.body)['results'];

    List<Movie> movies = data.map((json) => Movie.fromMap(json)).toList();
    return movies;
  }else{
    throw Exception("Failed to load upcoming movies");
  }
}
Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularApiUrl));

  if(response.statusCode == 200){
    final List<dynamic> data = json.decode(response.body)['results'];

    List<Movie> movies = data.map((json) => Movie.fromMap(json)).toList();
    return movies;
  }else{
    throw Exception("Failed to load upcoming movies");
  }
}
Future<List<Movie>> getTopRatedMovies() async {
     final response = await http.get(Uri.parse(topRatedApiUrl));

  if(response.statusCode == 200){
    final List<dynamic> data = json.decode(response.body)['results'];

    List<Movie> movies = data.map((json) => Movie.fromMap(json)).toList();
    return movies;
  }else{
    throw Exception("Failed to load upcoming movies");
  }
}

}