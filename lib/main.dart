import 'package:chat/firstPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the sender ID
    const int senderId = 3; // Fixed sender user ID

    return MaterialApp(
      title: 'Chat Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(), // Pass senderId to MyCustomPage
      debugShowCheckedModeBanner: false,
    );
  }
}
