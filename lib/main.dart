import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'models/item.dart';//para ios

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.green,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  var items = List<Item>();

  HomePage(){
    items = [];

    items.add(Item(title: "Item 1",done: false));
    items.add(Item(title: "Item 2",done: true));
    items.add(Item(title: "Item 3",done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Text('Menu'),
        title: Text("Todo List"),
        actions: <Widget>[
          Icon(Icons.plus_one),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.
        length, itemBuilder: (context, index){
          final item = widget.items[index];
          return CheckboxListTile(
            title:Text(item.title),
            key:Key(item.title),
            value: item.done,
            onChanged: (value){

            },
          );
      })  //widget acessar variavel class pai
    );
  }
}
