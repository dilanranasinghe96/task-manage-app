class Tasks {
  int ?id;
  String? title;
  String ?description;

  taskMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;

    return mapping;
  }
}


