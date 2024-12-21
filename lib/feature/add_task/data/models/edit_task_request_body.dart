class EditTaskRequestBody {
  final String image;
  final String title;
  final String desc;
  final String priority; // low, medium, high
  final String user;
  final String status;

  EditTaskRequestBody( {
    required this.status,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.user,
  });

  Map<String, dynamic> toJson() => {
    'image': image,
    'title': title,
    'desc': desc,
    'priority': priority,
    'user': user,
    "status": status,

  };

}
