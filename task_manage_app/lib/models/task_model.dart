class TaskModel {
  final int? id;
  final String? title;
  final String? desc;
  final String? dataAndTime;

  TaskModel({this.id, this.title, this.desc, this.dataAndTime});

  TaskModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        desc = res['desc'],
        dataAndTime = res['dataAndTime'];

  Map<String, Object?> toMap() {
    return {"id": id, "title": title, "desc": desc, "dataAndTime": dataAndTime};
  }
}
