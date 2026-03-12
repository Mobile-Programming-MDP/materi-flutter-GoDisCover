import 'dart:convert';
import 'package:film/models/movie.dart';
import 'package:film/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favMoviesJson = prefs.getStringList('favorite_movies') ?? [];

    setState(() {
      favoriteMovies = favMoviesJson.map((jsonStr) {
        return Movie.fromJson(jsonDecode(jsonStr));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Movies')),
      body: favoriteMovies.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.movie),
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    );
                    _loadFavorites();
                  },
                );
              },
            ),
    );
  }
}
