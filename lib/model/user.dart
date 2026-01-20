class User {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  final String password; // This is now the hashed password
  final String salt;     // The salt used for hashing

  User({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.salt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'password': password,
      'salt': salt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      salt: map['salt'] as String,
    );
  }
}
