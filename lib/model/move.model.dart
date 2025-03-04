class Movie{
  final int id;
  final String original_title;
  final String backDropPath;
  final String overview;
  final String posterPath;

  Movie({ required this.id, required this.original_title, required this.backDropPath, required this.overview, required this.posterPath });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      original_title: map['original_title'],
      backDropPath: map['backdrop_path'],
      overview: map['overview'],
      posterPath: map['poster_path'],
    );
  }


  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'original_title': original_title,
      'backdrop_path': backDropPath,
      'overview': overview,
      'poster_path': posterPath
    };
  }
}
