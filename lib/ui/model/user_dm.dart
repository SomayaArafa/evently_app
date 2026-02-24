
class UserDM {
  static const collectionName = "users";
  static UserDM? currentUser;
  String id;
  String email;
  String name;
  String address;
  String phoneNumber;
  List<String> favoriteEvents;

  UserDM({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.favoriteEvents = const [],
  });

  static UserDM fromJson(Map<String, dynamic> json) {
    List<dynamic> favorites = json['favorites'];
    return UserDM(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        favoriteEvents:favorites.map((id)=>id.toString()).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "address": address,
      "phone_number": phoneNumber,
      "favorites": favoriteEvents,
    };
  }
}
