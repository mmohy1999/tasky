class Task {
  String id;
  String? image;
  String title;
  String desc;
  String priority;
  String status;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Task({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // From JSON constructor
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["_id"],
      image: json["image"],
      title: json["title"],
      desc: json["desc"],
      priority: json["priority"],
      status: json["status"],
      user: json["user"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "image": image,
      "title": title,
      "desc": desc,
      "priority": priority,
      "status": status,
      "user": user,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}
