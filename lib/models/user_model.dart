import 'package:eve_mobile/models/movie_model.dart';

class User {
  final String id;
  final int created;
  final String username;
  final String name;
  final int lastActivity;
  final int totalMovies;
  final String language;
  final List<Movie> observableMovies;

  User(
      {required this.id,
      required this.created,
      required this.username,
      required this.name,
      required this.lastActivity,
      required this.totalMovies,
      required this.language,
      required this.observableMovies});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        created = json['created'] ?? 0,
        username = json['username'],
        name = json['name'],
        lastActivity = json['lastActivity'] ?? 0,
        totalMovies = json['totalMovies'],
        language = json['language'],
        observableMovies = (json['observableMovies'] as List).map((movie) => Movie.fromJson(movie)).toList();
}
