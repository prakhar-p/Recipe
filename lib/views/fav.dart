

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:receipe/views/home.dart';
import 'package:receipe/views/recipe_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/recipe_model.dart';
class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  List<RecipeModel> recipie = recpie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            //padding: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(top: 30, right: 20,left: 20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xff992e35),
                      const Color(0xff071930)
                    ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
            child:  Row(
              mainAxisAlignment: kIsWeb
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Tasty",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Overpass'),
                ),
                Text(
                  "Recipes",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                      fontFamily: 'Overpass'),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 410,
              width: MediaQuery.of(context).size.width,
              child: GridView(
                //mainAxisSpacing: 10.0,crossAxisSpacing: 10.0,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 10.0,maxCrossAxisExtent: 200.0
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  children: List.generate(recipie.length, (index) {
                    return GridTile(
                        child: RecipieTile(
                          title: recipie[index].label,
                          imgUrl: recipie[index].image,
                          desc: recipie[index].source,
                          url: recipie[index].url,
                        ));
                  })),
            ),
          ),
        ],
      )
    );

  }
}
class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({required this.title, required this.desc, required this.imgUrl, required this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Color _iconColor=Colors.black;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                        postUrl: widget.url,
                      )));
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 10)
            ),
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: (){setState(() {
                    if(_iconColor==Colors.black){
                      _iconColor=Colors.red;
                    }else
                    {
                      _iconColor=Colors.black;
                    }

                  });}, icon: Icon(Icons.thumb_up_rounded,color: _iconColor,)),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}