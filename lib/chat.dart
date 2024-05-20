import 'package:chat/hebergment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'user.dart';
import 'message.dart';
import 'HebergementDetailsPage.dart';

class ChatPage extends StatefulWidget {
  final int senderId;
  final int recipientId;

  const ChatPage({Key? key, required this.senderId, required this.recipientId})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  TextEditingController messageController = TextEditingController();
  User? sender;
  User? recipient;
  Timer? _timer;
  Map<int, Hebergement> hebergementsCache = {};

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _timer =
        Timer.periodic(Duration(seconds: 5), (timer) => fetchConversation());
  }

  Future<void> fetchUsers() async {
    var senderUrl = Uri.parse('http://localhost:62581/user/${widget.senderId}');
    var recipientUrl =
        Uri.parse('http://localhost:62581/user/${widget.recipientId}');
    try {
      var senderResponse = await http.get(senderUrl);
      var recipientResponse = await http.get(recipientUrl);
      if (senderResponse.statusCode == 200 &&
          recipientResponse.statusCode == 200) {
        setState(() {
          sender = User.fromJson(jsonDecode(senderResponse.body));
          recipient = User.fromJson(jsonDecode(recipientResponse.body));
        });
      } else {
        print("Failed to load users");
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  Future<void> fetchConversation() async {
    if (sender == null || recipient == null) return;
    var url = Uri.parse(
        'http://localhost:62581/message/conversation?senderId=${sender!.user_id}&recipientId=${recipient!.user_id}');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> messagesJson = jsonDecode(response.body);
        setState(() {
          messages =
              messagesJson.map((json) => Message.fromJson(json)).toList();
        });

        for (var message in messages) {
          if (message.hebergementId != null &&
              !hebergementsCache.containsKey(message.hebergementId)) {
            fetchHebergementDetails(message.hebergementId!);
          }
        }
      } else {
        print("Failed to load messages");
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  Future<void> fetchHebergementDetails(int hebergementId) async {
    if (!hebergementsCache.containsKey(hebergementId)) {
      var url = Uri.parse('http://localhost:62581/hebergement/$hebergementId');
      try {
        var response = await http.get(url);
        if (response.statusCode == 200) {
          Hebergement hebergement =
              Hebergement.fromJson(jsonDecode(response.body));
          setState(() {
            hebergementsCache[hebergementId] = hebergement;
          });
        } else {
          print("Failed to load hebergement details");
        }
      } catch (e) {
        print("Error fetching hebergement details: $e");
      }
    }
  }

  Future<void> sendMessage(String content) async {
    if (sender == null || recipient == null) return;
    var url = Uri.parse('http://localhost:62581/message/send');
    var message = Message(
      sender: sender!,
      recipient: recipient!,
      content: content,
      timestamp: DateTime.now(),
    );
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(message.toJson()));
      if (response.statusCode == 200) {
        setState(() {
          messages.add(message);
        });
        messageController.clear();
      } else {
        print("Failed to send message");
      }
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
        title: Text("Chat"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                bool isSentByMe = message.sender.user_id == widget.senderId;
                Hebergement? hebergement = message.hebergementId != null
                    ? hebergementsCache[message.hebergementId]
                    : null;

                return Column(
                  children: [
                    Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              isSentByMe ? Colors.blue[900] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message.content,
                            style: TextStyle(
                                color:
                                    isSentByMe ? Colors.white : Colors.black)),
                      ),
                    ),
                    if (hebergement != null) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HebergementDetailsPage(
                                    hebergement: hebergement)),
                          );
                        },
                        child: Align(
                          alignment: isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.zero, // Eliminated padding
                            margin: EdgeInsets.only(
                                top: 0, left: 10, right: 10, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/chat.png',
                                    width: 100),
                                Text(hebergement.nom,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
