import 'package:flutter/material.dart';
import 'package:http/http.dart';

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
	final sendDataTextField = TextEditingController();
  final List<String> movies = List<String>();

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
							Container(
								width: 300,
								child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Movie Name'
                  ),
                  style: TextStyle(
                    fontSize: 16.0
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
  ListView _movieList(){
    return ListView(children: <Widget>[]);
  }

	void fabPressed() {
		Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(
            title: Text('Movie List'),
          ),
          body: _movieList(),
        );
      })
	  );
	}
}