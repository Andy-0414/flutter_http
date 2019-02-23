import 'Movie.dart';

class SearchData {
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Movie> items;

  SearchData(
      {this.lastBuildDate, this.total, this.start, this.display, this.items});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    List<Movie> _items = List<Movie>();
    json['items'].forEach((dynamic x) {
      _items.add(Movie.fromJson(x));
    });
    return SearchData(
      lastBuildDate: json['lastBuildDate'],
      total: json['total'],
      start: json['start'],
      display: json['display'],
      items: _items,
    );
  }
}