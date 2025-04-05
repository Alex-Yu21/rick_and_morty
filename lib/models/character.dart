class CharacterModel {
  final Info? info;
  final List<Results>? results;

  CharacterModel({this.info, this.results});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      info: json['info'] != null ? Info.fromJson(json['info']) : null,
      results:
          json['results'] != null
              ? List<Results>.from(
                json['results'].map((v) => Results.fromJson(v)),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (info != null) 'info': info!.toJson(),
      if (results != null) 'results': results!.map((v) => v.toJson()).toList(),
    };
  }
}

class Info {
  final int? count;
  final int? pages;
  final String? next;
  final String? prev;

  Info({this.count, this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'pages': pages, 'next': next, 'prev': prev};
  }
}

class Results {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final Origin? origin;
  final Origin? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  Results({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'] != null ? Origin.fromJson(json['origin']) : null,
      location:
          json['location'] != null ? Origin.fromJson(json['location']) : null,
      image: json['image'],
      episode:
          json['episode'] != null ? List<String>.from(json['episode']) : null,
      url: json['url'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      if (origin != null) 'origin': origin!.toJson(),
      if (location != null) 'location': location!.toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }
}

class Origin {
  final String? name;
  final String? url;

  Origin({this.name, this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }
}
