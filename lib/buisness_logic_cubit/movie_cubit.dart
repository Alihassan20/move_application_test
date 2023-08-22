import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_application/data/model/popular_model.dart';

import '../data/repositry/popular_movie_repo.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MoviesState> {
  final PopularMovieRepository popularMovieRepository;
  List<Results>? moviesPopular =[];

  MovieCubit(this.popularMovieRepository) : super(CharactersInitial());

  Future<List<Results>?> getMovie() async {
    print("data");
    moviesPopular = await popularMovieRepository.getAllPopularMovie().then((moviesPopular) {
      emit(MovieLoaded(moviesPopular));
      this.moviesPopular = moviesPopular;
    }
    );
    return moviesPopular;
  }


}