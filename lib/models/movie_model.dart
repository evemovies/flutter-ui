class Movie {
  final String id;
  final String language;
  final String posterUrl;
  final bool released;
  final String title;
  final int year;

  Movie(
      {required this.id,
      required this.language,
      required this.posterUrl,
      required this.released,
      required this.title,
      required this.year});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        language = json['language'],
        posterUrl = json['posterUrl'],
        released = json['released'],
        title = json['title'],
        year = json['year'];
}
