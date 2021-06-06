import 'package:eve_mobile/services/api/api_service.dart';
import 'package:eve_mobile/models/movie_model.dart';

class MoviesAPIService {
  final _apiService = APIService();

  Future<List<Movie>> getMovies() async {
    var response = await _apiService.get('/api/v1/movies');
    List rawMovies = response.data['movies'];

    return rawMovies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
