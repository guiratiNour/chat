import 'package:chat/AjouterPersonne.dart';
import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<User> users = []; // Liste originale des utilisateurs
  List<User> displayedUsers = []; // Utilisateurs affichés après filtrage
  bool isLoading = true;
  static const int senderId = 3; // L'ID de l'expéditeur est toujours 3

  @override
  void initState() {
    super.initState();
    fetchChatUsers();
  }

  Future<void> fetchChatUsers() async {
    var url =
        Uri.parse('http://localhost:62581/message/user-chats?userId=$senderId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var userIds = Set<int>.from(
          jsonDecode(response.body).map((id) => int.parse(id.toString())));
      if (userIds.isNotEmpty) {
        fetchUsersByIds(userIds);
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to load chat users');
    }
  }

  Future<void> fetchUsersByIds(Set<int> ids) async {
    var queries = ids
        .map((id) => http.get(Uri.parse('http://localhost:62581/user/$id')))
        .toList();
    var responses = await Future.wait(queries);
    var fetchedUsers = responses
        .where((response) => response.statusCode == 200)
        .map((response) => User.fromJson(jsonDecode(response.body)))
        .toList();
    setState(() {
      users = fetchedUsers;
      displayedUsers = List<User>.from(
          users); // Initialise displayedUsers avec la liste complète
      isLoading = false;
    });
  }

  void filterUsers(String search) {
    if (search.isEmpty) {
      setState(() {
        displayedUsers = List<User>.from(
            users); // Réinitialise les utilisateurs affichés à tous les utilisateurs
      });
      return;
    }

    setState(() {
      displayedUsers = users
          .where((user) =>
              user.nom.toLowerCase().contains(search.toLowerCase()) ||
              user.prenom.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => filterUsers(value),
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Potential to add functionality for a search button press
                },
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.blue[900]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AjouterPersonne(senderId: senderId)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : displayedUsers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                          'assets/images/chat.png'), // Adjust the image path
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('No chat available',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: displayedUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey[100],
                        child: Text(
                          '${displayedUsers[index].prenom.substring(0, 1).toUpperCase()}${displayedUsers[index].nom.substring(0, 1).toUpperCase()}',
                          style: TextStyle(color: Colors.blueGrey[900]),
                        ),
                      ),
                      title: Text(
                          '${displayedUsers[index].prenom} ${displayedUsers[index].nom}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatPage(
                                  senderId: senderId,
                                  recipientId: displayedUsers[index].user_id)),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
