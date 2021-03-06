import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/movie_model.dart';

class MovieAPIService {
  final _apiService = APIService();

  Future searchMovies({required String title, required String language, int? year}) async {
    var url = '/api/v1/movies/search-movie?language=$language&title=$title';
    if (year != null) url += '&year=$year';

    var response = await _apiService.get(url);

    if (response.success) {
      return (response.data['foundMovies'] as List).map((movie) => Movie.fromJson(movie)).toList();
    }

    return response.error;
  }
}
