class UserDTO {
  final int id;
  final String login;
  final String password;
  final List<String> favorites;


  UserDTO ({
    required this.id,
    required this.login,
    required this.password,
    required this.favorites
  });

  factory UserDTO.fromDTO(Map<String, dynamic> json) {
    return UserDTO(
      id: json["id"],
      login: json["login"],
      password: json["password"],
      favorites: json["favorites"]
    );
  }
}