class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAvarage;
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAvarage,
  });
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "overview": overview,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
      "release_date": releaseDate,
      "vote_average": voteAvarage,
    };
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: (json["id"] as int?) ?? 0,
      title: (json["title"] as String?) ?? '',
      overview: (json["overview"] as String?) ?? '',
      posterPath: (json["poster_path"] as String?) ?? '',
      backdropPath: (json["backdrop_path"] as String?) ?? '',
      releaseDate: (json["release_date"] as String?) ?? '',
      voteAvarage: ((json["vote_average"] as num?)?.toDouble()) ?? 0.0,
    );
  }
}
