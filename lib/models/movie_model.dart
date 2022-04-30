String _getMoviePoster(String originalUrl) {
  // Sometimes movies don't have valid posters, then we replace it with a placeholder
  var isUrlValid = Uri.parse(originalUrl).isAbsolute;

  return isUrlValid ? originalUrl : 'https://cringemdb.com/img/movie-poster-placeholder.png';
}

class Movie {
  final String id;
  final String? language;
  final String posterUrl;
  final bool? released;
  final String title;
  final int year;

  Movie(
      {required this.id,
      this.language,
      required this.posterUrl,
      this.released,
      required this.title,
      required this.year});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        language = json['language'],
        posterUrl = _getMoviePoster(json['posterUrl'] ?? ''),
        released = json['released'],
        title = json['title'],
        year = json['year'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'language': language, 'posterUrl': posterUrl, 'released': released, 'title': title, 'year': year};
}
