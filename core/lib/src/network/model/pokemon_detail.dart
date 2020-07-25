class PokemonDetail {
  String name;
  int height;
  int weight;
  int baseExperience;
  Sprites sprites;
  List<Types> types;

  PokemonDetail(
      {this.name,
      this.height,
      this.weight,
      this.baseExperience,
      this.sprites,
      this.types});

  PokemonDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    height = json['height'];
    weight = json['weight'];
    baseExperience = json['base_experience'];
    sprites =
        json['sprites'] != null ? new Sprites.fromJson(json['sprites']) : null;
    if (json['types'] != null) {
      types = new List<Types>();
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
  }
}

class Sprites {
  String frontDefault;

  Sprites({this.frontDefault});

  Sprites.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }
}

class Types {
  int slot;
  Type type;

  Types({this.slot, this.type});

  Types.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }
}

class Type {
  String name;
  String url;

  Type({this.name, this.url});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
