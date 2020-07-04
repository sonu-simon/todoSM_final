import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textEditingController = TextEditingController();
  String toAdd;
  List<String> todoItems = [];

  void showAddDialog() {
    textEditingController.text = "";
    final _formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: textEditingController,
                  autofocus: true,
                  onChanged: (value) {
                    toAdd = value;
                  },
                  validator: (_value) {
                    if (_value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        todoItems.add(toAdd);
                        Navigator.pop(context);
                        setState(() {});
                      }
                    },
                    child: Text("ADD"),
                    color: Colors.green,
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              })
        ],
        backgroundColor: Colors.green[700],
        title: Text(
          "My Tasks",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: (todoItems.isEmpty)
          ? Center(
              child: Text(
                "No Task Available",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  elevation: 5.0,
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text(
                      todoItems[index],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onLongPress: () {
                      setState(() {
                        todoItems.removeAt(index);
                      });
                    },
                  ),
                );
              },
              itemCount: todoItems.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green[700],
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
