
import '../../../core/utils/functions.dart';

class MovieDetailsModel {
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String releaseDate;
  final String genres;
  final String? runtime;
  final String overview;
  final double voteAverage;
  final String voteCount;
  final String trailerUrl;


  const MovieDetailsModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.trailerUrl
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      tmdbID: json['id'],
      title: json['title'],
      posterUrl: getPosterUrl(json['poster_path']),
      backdropUrl: getBackdropUrl(json['backdrop_path']),
      releaseDate: getDate(json['release_date']),
      genres: getGenres(json['genres']),
      runtime: getLength(json['runtime']),
      overview: json['overview'] ?? '',
      voteAverage:
      double.parse((json['vote_average'] as double).toStringAsFixed(1)),
      voteCount: getVotesCount(json['vote_count']),
      trailerUrl: getTrailerUrl(json)
    );
  }
}
