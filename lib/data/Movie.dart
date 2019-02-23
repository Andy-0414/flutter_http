class Movie {
  String title;
  String link;
  String image;
  String subtitle;
  String pubData;
  String director;
  String actor;
  String userRating;

  Movie(
      {this.title,
      this.actor,
      this.director,
      this.image,
      this.link,
      this.pubData,
      this.subtitle,
      this.userRating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      link: json['link'],
      image: json['image'],
      subtitle: json['subtitle'],
      pubData: json['pubData'],
      director: json['director'],
      actor: json['actor'],
      userRating: json['userRating'],
    );
  }
}
