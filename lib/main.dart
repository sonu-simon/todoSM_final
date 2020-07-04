import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    bool validated = true;
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
                TextField(
                  controller: textEditingController,
                  autofocus: true,
                  onChanged: (value) {
                    toAdd = value;
                  },
                  // decoration: InputDecoration(
                  //     errorText:
                  //         validated ? null : "This field cannot be empty"),
                ),
                Visibility(
                  visible: !validated,
                  child: Text("This field cannot be empty"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (textEditingController.text.isEmpty) {
                        Navigator.pop(context);
                      } else {
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
  final String name = "CSI member";
  final String phone = "8547886720";
  final String email = "sonuisplaying@gmail.com";
  final String imageurl =
      "https://upload.wikimedia.org/wikipedia/en/e/e0/Csi_logo_india.jpg";
  final String whatsapp = "8547886720";

  _whatsappURL() async {
    String whatsappURL = "https://wa.me/91" + whatsapp;
    launch(whatsappURL);
  }

  _phoneURL() async {
    String phoneURL = "tel:+91" + phone;
    launch(phoneURL);
  }

  _smsURL() async {
    String smsURL = "sms:+91" + phone;
    launch(smsURL);
  }

  _emailURL() async {
    String smsURL = "mailto:" + email;
    launch(smsURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        backgroundColor: Colors.green,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageurl),
                    radius: 80,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 4, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    phone,
                    style: TextStyle(fontSize: 18),
                  )),
                  IconButton(
                      icon: Icon(Icons.watch_later), onPressed: _whatsappURL),
                  IconButton(icon: Icon(Icons.message), onPressed: _smsURL),
                  IconButton(icon: Icon(Icons.phone), onPressed: _phoneURL),
                ],
              ),
            ),
            emailTile(email, _emailURL),
          ]),
    );
  }

  Widget emailTile(String email, Function emailFn) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              child: Text(
            email,
            style: TextStyle(fontSize: 16),
          )),
          IconButton(icon: Icon(Icons.mail), onPressed: emailFn),
        ],
      ),
    );
  }
}
