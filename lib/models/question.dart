class Question {
  late String name, label, widget;
  late String? type;
  late bool required;
  late List<String>? options;

  Question(this.name, this.label, this.widget, this.type, this.required,
      this.options);

  Question.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    label = json["label"];
    widget = json["widget"];
    type = json["type"];
    required = json["required"];
    options = json["options"];
  }
}
