class Users {
  Users({
    this.id,
    this.username,
    this.fullName,
    this.babyName,
    this.phoneNumber,
    this.babyDob,
    this.babyStage,
    this.accountMedicalConditiob,
    this.accountAddress,
    this.diamond,
  });

  String? id;
  String? username;
  String? fullName;
  String? babyName;
  String? phoneNumber;
  DateTime? babyDob;
  bool? babyStage;
  List<AccountMedicalConditiob?>? accountMedicalConditiob;
  List<dynamic>? accountAddress;
  int? diamond;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        babyName: json["baby_name"],
        phoneNumber: json["phone_number"],
        babyDob: json["baby_dob"] == null
            ? DateTime.now()
            : DateTime.parse(json["baby_dob"]),
        babyStage: json["baby_stage"],
        accountMedicalConditiob: json["account_medicalConditiob"] == null
            ? []
            : List<AccountMedicalConditiob?>.from(
                json["account_medicalConditiob"]!
                    .map((x) => AccountMedicalConditiob.fromJson(x))),
        accountAddress: json["account_address"] == null
            ? []
            : List<dynamic>.from(json["account_address"]!.map((x) => x)),
        diamond: json["dimond"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "baby_name": babyName,
        "phone_number": phoneNumber,
        "baby_dob":
            "${babyDob!.year.toString().padLeft(4, '0')}-${babyDob!.month.toString().padLeft(2, '0')}-${babyDob!.day.toString().padLeft(2, '0')}",
        "baby_stage": babyStage,
        "account_medicalConditiob": accountMedicalConditiob == null
            ? []
            : List<dynamic>.from(
                accountMedicalConditiob!.map((x) => x!.toJson())),
        "account_address": accountAddress == null
            ? []
            : List<dynamic>.from(accountAddress!.map((x) => x)),
        "dimond": diamond
      };
}

class AccountMedicalConditiob {
  AccountMedicalConditiob({
    this.id,
    this.description,
    this.medicalCondition,
  });

  String? id;
  String? description;
  List<String?>? medicalCondition;

  factory AccountMedicalConditiob.fromJson(Map<String, dynamic> json) =>
      AccountMedicalConditiob(
        id: json["id"],
        description: json["description"],
        medicalCondition: json["MedicalCondition"] == null
            ? []
            : List<String?>.from(json["MedicalCondition"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "MedicalCondition": medicalCondition == null
            ? []
            : List<dynamic>.from(medicalCondition!.map((x) => x)),
      };
}
