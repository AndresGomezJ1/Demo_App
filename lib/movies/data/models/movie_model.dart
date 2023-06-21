import '../../../core/utils/functions.dart';

class MovieModel {
  final int tmdbID;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final double voteAverage;
  final String releaseDate;
  final String overview;

  const MovieModel({
    required this.tmdbID,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    tmdbID: json['id'],
    title: json['title'],
    posterUrl: getPosterUrl(json['poster_path']),
    backdropUrl: getBackdropUrl(json['backdrop_path']),
    voteAverage: double.parse((json['vote_average']).toStringAsFixed(1)),
    releaseDate: getDate(json['release_date']),
    overview: json['overview'] ?? ''
  );
}
