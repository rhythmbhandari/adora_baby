class Reviews {
  Reviews({
    required this.id,
    required this.grade,
    required this.review,
    required this.product,
    required this.createdBy,
  });

  String id;
  String grade;
  String review;
  String product;
  CreatedBy? createdBy;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    id: json["id"],
    grade: json["grade"],
    review: json["review"],
    product: json["product"],
    createdBy: json["created_by"] == null ? null: CreatedBy.fromJson(json["created_by"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grade": grade,
    "review": review,
    "product": product,
    "created_by": createdBy?.toJson(),
  };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePhoto,
  });

  String id;
  String fullName;
  String username;
  dynamic profilePhoto;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: json["id"],
    fullName: json["full_name"],
    username: json["username"],
    profilePhoto: json["profile_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "username": username,
    "profile_photo": profilePhoto,
  };
}

class ProfilePhotoClass {
  ProfilePhotoClass({
    required this.id,
    required this.name,
    required this.pictureOff,
  });

  String id;
  String name;
  String pictureOff;

  factory ProfilePhotoClass.fromJson(Map<String, dynamic> json) => ProfilePhotoClass(
    id: json["id"],
    name: json["name"],
    pictureOff: json["picture_off"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture_off": pictureOff,
  };
}
