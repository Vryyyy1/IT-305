class User {
  final String username;
  final String email;
  final String urlAvatar;

  const User({
    required this.username,
    required this.email,
    required this.urlAvatar,
  });

  String get name => username;
  String get rarity => email;
  String get image => urlAvatar;

  factory User.fromJson(Map<String, dynamic> json) {
    String image = (json['image'] ?? json['urlAvatar'] ?? '') as String;
    if (image.isNotEmpty &&
        !image.startsWith('http://') &&
        !image.startsWith('https://') &&
        !image.startsWith('assets/')) {
      image = 'assets/$image';
    }

    return User(
      username: (json['name'] ?? json['username'] ?? 'Unknown Pokemon') as String,
      email: (json['rarity'] ?? json['email'] ?? 'N/A') as String,
      urlAvatar: image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'urlAvatar': urlAvatar,
    };
  }
}