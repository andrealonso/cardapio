import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estabelecimentos'),
        centerTitle: true,
      ),
      body: Container(
        
        child: Column(children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
            ),
            child: Row(children: [
              Container(
                height: 50,
                width: 300,
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Pesquisar estabelecimentos'),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: null)
            ]),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
              ],
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Filtrar');
        },
        child: Icon(
          Icons.filter_list,
          size: 34,
        ),
        elevation: 20,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 20,
      ),
      color: Colors.white,
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 80,
            width: 60,
            child: Icon(
              Icons.photo,
              size: 50,
            ),
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Nome do estabelecimento',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('4 Km'),
            ]),
          ),
          Column(children: [
            Icon(Icons.favorite_border, color: Colors.red),
            Icon(
              Icons.thumb_up,
              color: Colors.blue,
            ),
            Text('456'),
          ]),
        ],
      ),
    );
  }
}
