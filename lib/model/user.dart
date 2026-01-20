class User {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  final String password; // In a real app, this should be a hash

  User({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
