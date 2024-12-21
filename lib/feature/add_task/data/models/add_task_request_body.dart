class AddTaskRequestBody {
  final String image;
  final String title;
  final String desc;
  final String priority; // low, medium, high
  final String dueDate;

  AddTaskRequestBody({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() => {
    'image': image,
    'title': title,
    'desc': desc,
    'priority': priority,
    'dueDate': dueDate,
  };

}
