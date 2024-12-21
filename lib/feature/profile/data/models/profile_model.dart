class ProfileModel {
  String id;
  String displayName;
  String phone;
  List<String> roles;
  bool active;
  int experienceYears;
  String address;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ProfileModel({
    required this.id,
    required this.displayName,
    required this.phone,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      displayName: json['displayName'],
      phone: json['username'],
      roles: List<String>.from(json['roles']),
      active: json['active'],
      experienceYears: json['experienceYears'],
      address: json['address'],
      level: json['level'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

}
