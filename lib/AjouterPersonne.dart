import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:chat/user.dart'; // Assurez-vous que le chemin d'import est correct
import 'dart:convert';
import 'package:http/http.dart' as http;

class AjouterPersonne extends StatefulWidget {
  final int senderId; // Recevoir senderId de MyApp
  const AjouterPersonne({Key? key, required this.senderId}) : super(key: key);

  @override
  _AjouterPersonneState createState() => _AjouterPersonneState();
}

class _AjouterPersonneState extends State<AjouterPersonne> {
  TextEditingController searchController = TextEditingController();
  List<User> users = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: (value) => fetchUsers(value),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${users[index].prenom} ${users[index].nom}"),
            trailing: IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      senderId: widget.senderId,
                      recipientId: users[index].user_id,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> fetchUsers(String search) async {
    if (search.isEmpty) {
      setState(() {
        isSearching = false;
        users = [];
      });
      return;
    }

    var url = Uri.parse(
        'http://localhost:62581/user/findUserByNomOrPrenom?search=$search');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        users = List<User>.from(
            json.decode(response.body).map((x) => User.fromJson(x)));
        isSearching = true;
      });
    } else {
      setState(() {
        isSearching = false;
        users = [];
      });
    }
  }
}
