class CharacterModel {
  final String name;
  final String image;
  final String status;

  CharacterModel({
    required this.name,
    required this.image,
    required this.status,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['name'],
      image: json['image'],
      status: json['status'],
    );
  }
}
