import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:github_search_bloc/src/models/Item.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;

  ItemDetailPage({this.item});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: widget.item.owner.url,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.item?.owner.avatarUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.item?.fullName, style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Text(widget.item?.description),
                    ],
                  ),
                ),

                Container(
                  width: size.width * 0.9,
                  color: Colors.blue,
                  child: FlatButton.icon(
                    icon: Icon(Icons.keyboard_backspace, color: Colors.white,),
                    label: Text("Voltar a listagem", style: TextStyle(color: Colors.white),),
                    onPressed: () => Navigator.pop(context),
                  ),
                )

              ],
            ),
          ),
          ),
      ),
    );
  }
}