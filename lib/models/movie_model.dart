String _getMoviePoster(String originalUrl) {
  // Sometimes movies don't have valid posters, then we replace it with a placeholder
  var isUrlValid = Uri.parse(originalUrl).isAbsolute;

  return isUrlValid
      ? originalUrl
      : 'https://i1.wp.com/www.countme2020.org/wp-content/uploads/woocommerce-placeholder.jpg?resize=300%2C375&ssl=1';
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
      : id = json['_id'] ?? json['id'],
        language = json['language'],
        posterUrl = _getMoviePoster(json['posterUrl']),
        released = json['released'],
        title = json['title'],
        year = json['year'];
}
