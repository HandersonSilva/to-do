import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    // items.add(Item(title: "Item 1",done: false));
    // items.add(Item(title: "Item 2",done: true));
    // items.add(Item(title: "Item 3",done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  _HomePageState(){
    load();
  }

  void Add(){
    if (newTaskCtrl.text.isEmpty){
      return;
    }
    setState(() {
      widget.items.add(Item(title: newTaskCtrl.text,done: false));
      save();
      newTaskCtrl.clear();
    });
  }
 
  void remove(int index){
      setState(() {
        widget.items.removeAt(index);
        save();
      });
  }


  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null){
      Iterable decode = jsonDecode(data);
      List<Item> result = decode.map((e) => Item.fromJson(e)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  save() async{
     var prefs = await SharedPreferences.getInstance();
     await prefs.setString('data',jsonEncode(widget.items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Text('Menu'),
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: "Nova Tarefa",labelStyle: TextStyle(color: Colors.white)),
          ),
          
        actions: <Widget>[
          Icon(Icons.plus_one),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.items.
        length, itemBuilder: (context, index){
          final item = widget.items[index];
          return Dismissible( 
            key:Key(item.title), 
            background: Container( color: Colors.red.withOpacity(0.2),
            child:Padding(padding: EdgeInsets.all(20),
            child:  Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("Excluir"),
                ],
              ),
              ),
              ),
              ),
            onDismissed: (direction){
              // if (direction == DismissDirection.endToStart){

              // }

              remove(index);

            },
            child: CheckboxListTile(
                title:Text(item.title),
                value: item.done,
                onChanged: (value){
                  setState(() {
                    item.done = value;
                    save();
                  });
                },
          ));
      }),//widget acessar variavel class pai
      floatingActionButton: FloatingActionButton(
      onPressed: Add,
      child: Icon(Icons.add),
      backgroundColor: Colors.pink)
    );
  }
}

