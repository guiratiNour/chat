import 'package:chat/hebergment.dart';
import 'package:flutter/material.dart';

class HebergementDetailsPage extends StatelessWidget {
  final Hebergement hebergement; // Ajoutez ce champ

  // Modifiez le constructeur pour accepter un objet Hebergement
  HebergementDetailsPage({Key? key, required this.hebergement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails de l'hébergement"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nom: ${hebergement.nom}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Description: ${hebergement.description}",
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
