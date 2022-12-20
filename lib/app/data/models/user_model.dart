// class User {
//   User({
//     this.id,
//     this.username,
//     this.email,
//     this.fullName,
//     this.babyName,
//     this.phoneNumber,
//     this.babyDob,
//     this.babyStage,
//     this.accountMedicalConditiob,
//   });
//
//   String? id;
//   String? username;
//   dynamic email;
//   String fullName;
//   String babyName;
//   String phoneNumber;
//   DateTime babyDob;
//   bool babyStage;
//   List<AccountMedicalConditiob> accountMedicalConditiob;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"] == null ? null : json["id"],
//     username: json["username"] == null ? null : json["username"],
//     email: json["email"],
//     fullName: json["full_name"] == null ? null : json["full_name"],
//     babyName: json["baby_name"] == null ? null : json["baby_name"],
//     phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
//     babyDob: json["baby_dob"] == null ? null : DateTime.parse(json["baby_dob"]),
//     babyStage: json["baby_stage"] == null ? null : json["baby_stage"],
//     accountMedicalConditiob: json["account_medicalConditiob"] == null ? null : List<AccountMedicalConditiob>.from(json["account_medicalConditiob"].map((x) => AccountMedicalConditiob.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "token": token == null ? null : token.toJson(),
//     "username": username == null ? null : username,
//     "email": email,
//     "full_name": fullName == null ? null : fullName,
//     "baby_name": babyName == null ? null : babyName,
//     "phone_number": phoneNumber == null ? null : phoneNumber,
//     "baby_dob": babyDob == null ? null : babyDob.toIso8601String(),
//     "baby_stage": babyStage == null ? null : babyStage,
//     "account_medicalConditiob": accountMedicalConditiob == null ? null : List<dynamic>.from(accountMedicalConditiob.map((x) => x.toJson())),
//   };
// }
//
// class AccountMedicalConditiob {
//   AccountMedicalConditiob({
//     this.id,
//     this.description,
//     this.medicalCondition,
//     this.createdBy,
//   });
//
//   String id;
//   String description;
//   List<String> medicalCondition;
//   CreatedBy createdBy;
//
//   factory AccountMedicalConditiob.fromJson(Map<String, dynamic> json) => AccountMedicalConditiob(
//     id: json["id"] == null ? null : json["id"],
//     description: json["description"] == null ? null : json["description"],
//     medicalCondition: json["MedicalCondition"] == null ? null : List<String>.from(json["MedicalCondition"].map((x) => x)),
//     createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "description": description == null ? null : description,
//     "MedicalCondition": medicalCondition == null ? null : List<dynamic>.from(medicalCondition.map((x) => x)),
//     "created_by": createdBy == null ? null : createdBy.toJson(),
//   };
// }
