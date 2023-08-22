
import 'package:move_application/data/model/popular_model.dart';

import '../web_services/popular_movie_web_services.dart';

class PopularMovieRepository {
  final PopularMoviesWebServices? popularMoviesWebServices;

  PopularMovieRepository(this.popularMoviesWebServices);

  Future<List<Results>?> getAllPopularMovie() async {
    final popularMovie = await popularMoviesWebServices!.fetchMovies();
    return  popularMovie;
  }





}