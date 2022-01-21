class Movie {
  final String? title;
  final String? poster;

  Movie({ this.title, this.poster });

  Movie.fromJson(Map<String, dynamic> json)
    : title = json['Title'],
      poster = json['Poster'];

  Map<String, dynamic> toJson() => {
    'Title': title,
    'Poster': poster
  };
}