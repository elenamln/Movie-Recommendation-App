import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart' show CarouselOptions, CarouselSlider;
import 'package:my_movie_app/api/api.dart';
import 'package:my_movie_app/screens/moviedetailpage.dart' show MovieDetailPage;
import '../model/move.model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> topRatedMovies;

  @override
  void initState() {
    upcomingMovies = Api().getUpcomingMovies();
    popularMovies = Api().getPopularMovies();
    topRatedMovies = Api().getTopRatedMovies();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed:() {}, icon: const Icon(Icons.menu)),
        title: const Text("🍿 What to watch 🍿"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Movies",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              // Carosel of upcoming movies

              FutureBuilder(future: upcomingMovies,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }
                final movies = snapshot.data!;

                return CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index, movieIndex) {
                  final movie = movies[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movieId: movie.id),
                          ),
                      );
                    },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/original${movie.backDropPath}",
                      fit: BoxFit.cover,
                    ),
                    ),
                    );
                  },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 1.4,
                  autoPlayInterval: const Duration(seconds: 3)
                )
                );
              },
            ),

            const Text(
              "Popular Movies",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 200,
              child: FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  final movies = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(movieId: movie.id),
                              ),
                          );
                        },
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${movie.posterPath}",
                          fit: BoxFit.cover,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        const Text(
          "Top Rated Movies",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          height: 200,
          child: FutureBuilder(
            future: topRatedMovies,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator(),);
              }
              final movies = snapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(movieId: movie.id),
                          ),
                      );
                    },
                    child: Container (
                      width: 150,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${movie.posterPath}",
                          fit: BoxFit.cover,
                          height: 120,
                          width: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                 );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
