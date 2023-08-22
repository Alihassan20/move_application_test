




import '../data/model/popular_model.dart';

abstract class MoviesState {}

class CharactersInitial extends MoviesState {}


class MovieLoaded extends MoviesState {
  final  List<Results>? popularMovie;

  MovieLoaded(this.popularMovie);
}

// class QuotesLoaded extends CharactersState {
//   final List<Quote> quotes;
//
//   QuotesLoaded(this.quotes);
// }