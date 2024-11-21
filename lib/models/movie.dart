class Movie {
  final String title;
  final String poster;
  final List<String> genres;
  final String rating;

  Movie(
      {required this.title,
        required this.poster,
        required this.genres,
        required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      poster: json['Poster'],
      genres: json['Genre'].split(','),
      rating: json['imdbRating'],
    );
  }
}
