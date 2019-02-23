import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "HTTP Req&Res",
			theme: ThemeData(
				primaryColor: Colors.pinkAccent
			),
			home: Main(),
		);
	}
}

class Main extends StatefulWidget {
	@override
	_MainState createState() => _MainState();
}

class _MainState extends State<Main> {
	final movieNameTextField = TextEditingController();
  //List<Movie> movies = List<Movie>();

	@override
	Widget build(BuildContext context) {
	  return Scaffold(
			appBar: AppBar(
				title: Text('HTTP Req&Res',style: TextStyle(fontSize: 18.0)),
			),
			body: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				mainAxisSize: MainAxisSize.max,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					Column(
						mainAxisAlignment: MainAxisAlignment.center,
						mainAxisSize: MainAxisSize.max,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: <Widget>[
              Text('Hello World!')
              ,
							Container(
								width: 300,
								child: TextField(
                  controller: movieNameTextField,
                  decoration: InputDecoration(
                    hintText: 'Movie Name'
                  ),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black
                  ),
                ),
							)
						],
					)
				],
			),
			floatingActionButton:  FloatingActionButton(
				child:  Icon(Icons.zoom_in),
				onPressed: fabPressed),
		);
	}


  ListView movieList(List<Movie> movies){

    final Iterable<Widget> tiles = movies.map((Movie m){
      return Container(
        margin: EdgeInsets.all(15),
        height: 100,
        child: Row(
          children: <Widget>[
            Image(
              image: NetworkImage(m.image),
              height: 100,
              width: 80,),
            Flexible(
              fit: FlexFit.loose,
              child: Text('   '+m.title.toString().replaceAll('<b>', '[').replaceAll('</b>', ']'),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16
                )
              ),
            ) 
          ],
        )
      );
    });
    List<Widget> divided = ListTile.divideTiles(context: context,tiles: tiles).toList();
    return ListView(children: divided);
  }

  Future<SearchData> fetchMovie(String _movieName) async{
    final response = await http.get('https://openapi.naver.com/v1/search/movie.json?query=$_movieName',
      headers: {
        'X-Naver-Client-Id':'XO1qI2HpcdWPh2hLwD58',
        'X-Naver-Client-Secret':'h9t2o90uuX'
      });
      return SearchData.fromJson(json.decode(response.body));
  }
	void fabPressed() {
    String movieName = movieNameTextField.text;
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(
            title: Text('[$movieName] Search Data'),
          ),
          body: FutureBuilder<SearchData>(
            future:fetchMovie(movieName),
            builder: (context, snapshot){
              return snapshot.hasData
              ? movieList(snapshot.data.items)
              : Center(child:CircularProgressIndicator());
            },
          ),
        );
      })
    );
	}
}

class SearchData{
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Movie> items;
  
  SearchData({this.lastBuildDate,this.total,this.start,this.display,this.items});

  factory SearchData.fromJson(Map<String,dynamic> json){
    List<Movie> _items = List<Movie>();
    json['items'].forEach((dynamic x){
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

class Movie {
  String title;
  String link;
  String image;
  String subtitle;
  String pubData;
  String director;
  String actor;
  String userRating;

  Movie({this.title,this.actor,this.director,this.image,this.link,this.pubData,this.subtitle,this.userRating});

  factory Movie.fromJson(Map<String,dynamic> json){
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