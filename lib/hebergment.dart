class Hebergement {
  int hebergement_id;
  String nom;
  String description;
  String ville;
  String pays;
  double prix;
  String distance; // Modifié pour correspondre à Spring
  String contact;
  String adresse;
  String politiqueAnnulation;
  String nbEtoile;
  double superficie;
  int nb_Salles_De_Bains;
  int nb_Chambres;
  bool dispo;
  int nombreDeReservations;
  String imagePath;

  Hebergement({
    required this.hebergement_id,
    required this.nom,
    required this.description,
    required this.ville,
    required this.pays,
    required this.prix,
    required this.distance, // Maintenant une String
    required this.contact,
    required this.adresse,
    required this.politiqueAnnulation,
    required this.nbEtoile,
    required this.superficie,
    required this.nb_Salles_De_Bains,
    required this.nb_Chambres,
    required this.dispo,
    required this.nombreDeReservations,
    required this.imagePath,
  });

  factory Hebergement.fromJson(Map<String, dynamic> json) {
    return Hebergement(
      hebergement_id: json['hebergement_id'] as int? ?? 0,
      nom: json['nom'] as String? ?? '',
      description: json['description'] as String? ?? '',
      ville: json['ville'] as String? ?? '',
      pays: json['pays'] as String? ?? '',
      prix: (json['prix'] as num? ?? 0.0).toDouble(),
      distance: json['distance'] as String? ?? '',
      contact:
          json['phone'] as String? ?? '', // Utilisez le champ correct du JSON
      adresse: json['adresse'] as String? ?? '',
      politiqueAnnulation: json['politiqueAnnulation'] as String? ?? '',
      nbEtoile: json['nbEtoile'] as String? ?? '',
      superficie: (json['superficie'] as num? ?? 0.0).toDouble(),
      nb_Salles_De_Bains: json['nb_Salles_De_Bains'] as int? ?? 0,
      nb_Chambres: json['nb_Chambres'] as int? ?? 0,
      dispo: json['dispo'] as bool? ?? false,
      nombreDeReservations: json['nombreDeReservations'] as int? ?? 0,
      imagePath: json['imagePath'] as String? ?? 'assets/images/chat.png',
    );
  }
}
