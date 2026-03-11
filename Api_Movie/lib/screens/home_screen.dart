import 'package:film/models/movie.dart';
import 'package:film/service/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  final ApiService _apiService = ApiService();
  Widget build(BuildContext context) {
    List<Movie> _allMovies = [];
    List<Movie> _trendingMovies = [];
    List<Movie> _popularMovies = [];

    Future<void> _loadMovies() async {
      final List<Map<String, dynamic>> allMoviesData = await _apiService
          .getAllMovies();
      final List<Map<String, dynamic>> trendingMoviesData = await _apiService
          .getTrendingMovies();
      final List<Map<String, dynamic>> popularMoviesData = await _apiService
          .getPopularMovies();

      setState(() {
        _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
        _trendingMovies = trendingMoviesData
            .map((e) => Movie.fromJson(e))
            .toList();
        _popularMovies = popularMoviesData
            .map((e) => Movie.fromJson(e))
            .toList();
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Film")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildMovieList("All Movie", _allMovies),
            _buildMovieList("Trending Movie", _trendingMovies),
            _buildMovieList("Popular Movie", _popularMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie movie = movies[index];
              return Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 5),
                    Text(
                      movie.title.length > 14
                          ? '${movie.title.substring(0, 10)}...'
                          : movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
