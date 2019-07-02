import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_search_bloc/src/bloc/SearchBloc.dart';
import 'package:github_search_bloc/src/models/Item.dart';
import 'package:github_search_bloc/src/models/SearchResult.dart';
import 'package:github_search_bloc/src/pages/ItemDetailPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SearchBloc _searchBloc;

@override
void initState() { 
  _searchBloc = SearchBloc();
  super.initState();
}

@override
void dispose() { 
  _searchBloc.dispose();
  super.dispose();
}

  _inputField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: _searchBloc.searchSink.add,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Pesquisar",
            hintText: "Digite algo a ser pesquisado"
          ),
        ),
      ),
    );
  }

  _item(Items item) {
    return Container(
      child: ListTile(
        leading: Image.network(item.owner.avatarUrl),
        title: Text(item.name),
        subtitle: item.description == null ? Text('') : Text(item?.description , maxLines: 3) ,
        onTap: () => 
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ItemDetailPage(item: item)
              )
             )
        ,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Busca Repositório Github"),
         centerTitle: true,
       ),
       body: ListView(
         children: <Widget>[
           _inputField(context),
           StreamBuilder<SearchResult>(
             stream: _searchBloc.apiResultFlux,
             builder: (BuildContext context,AsyncSnapshot<SearchResult> snapshot) {
               return snapshot.hasData ? ListView.builder(
                 shrinkWrap: true,
                 physics: ClampingScrollPhysics(),
                 itemCount: snapshot.data.items.length,
                 itemBuilder: (BuildContext context, int index){
                   Items item =  snapshot.data.items[index];
                   return _item(item);
                 }, 
               ): Center(child: CircularProgressIndicator(),);
             }
           )
         ],
       ),
    );
  }
}

