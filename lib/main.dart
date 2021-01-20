import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_image_background_list/photo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String authority = 'api.unsplash.com';

  final String endpoint = '/photos';

  // get your own UnSplash clientId from here:
  // https://unsplash.com/documentation#registering-your-application
  // you first create a developer account
  // then register an app
  // the clientId is the App's Access Key
  final String clientId = '';

  List<Photo> photos;

  void getImages() async {
    Response response =
        await get(Uri.https(authority, endpoint, {'client_id': clientId}));

    setState(() {
      photos = photoFromJson(response.body);
    });

    print(photos);
  }

  @override
  void initState() {
    super.initState();

    // getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: photos == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) => ListItem(
                imageUrl: photos[index].urls.full,
              ),
              itemCount: photos.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImages();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String imageUrl;

  const ListItem({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {},
        child: Container(
          height: 260,
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: BoxConstraints(maxHeight: 130),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(16, 21, 16, 16),
          ),
        ),
      ),
    );
  }
}
