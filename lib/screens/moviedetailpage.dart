// Second screen for displaying movie details
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_movie_app/api/constant.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId; // Movie ID passed from the previous screen

  const MovieDetailPage({super.key, required this.movieId});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}


class _MovieDetailPageState extends State<MovieDetailPage> {
  late Future<Map<String, dynamic>> movieDetails;

  // Fetch movie details from TMDB API
  Future<Map<String, dynamic>> fetchMovieDetails() async {
    final url =
        "https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the JSON response
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  @override
  void initState() {
    super.initState();
    movieDetails = fetchMovieDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Movie Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: movieDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movie = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/original${movie['backdrop_path']}",
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  movie['original_title'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['overview'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Release Date: ${movie['release_date']}',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}