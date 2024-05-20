class User {
  final int user_id; // Ajout de la propriété user_id
  final String nom;
  final String prenom;
  final String email;
  /*final String image_path;*/

  User({
    required this.user_id,
    required this.nom,
    required this.prenom,
    required this.email,
    /* required this.image_path,*/
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      user_id: json[
          'user_id'], // Assurez-vous de récupérer la valeur user_id correctement
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      /* image_path: json['image_path'] ?? 'default_image_path',*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id':
          user_id, // Assurez-vous de sérialiser la valeur user_id correctement
      'nom': nom,
      'prenom': prenom,
      'email': email,
      /*'image_path': image_path,*/
    };
  }
}
