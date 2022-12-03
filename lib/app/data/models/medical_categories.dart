class MedicalCategories {
  MedicalCategories({
    required this.id,
    required this.name,
    required this.medicalcategories,
  });

  String id;
  String name;
  List<Medicalcategory> medicalcategories;

  factory MedicalCategories.fromJson(Map<String, dynamic> json) => MedicalCategories(
    id: json["id"],
    name: json["name"],
    medicalcategories: List<Medicalcategory>.from(json["medicalcategories"].map((x) => Medicalcategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "medicalcategories": List<dynamic>.from(medicalcategories.map((x) => x.toJson())),
  };
}

class Medicalcategory {
  Medicalcategory({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Medicalcategory.fromJson(Map<String, dynamic> json) => Medicalcategory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
