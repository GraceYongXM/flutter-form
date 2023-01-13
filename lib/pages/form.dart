import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:grace_form/models/question.dart';

class GraceFormHook extends HookWidget {
  GraceFormHook({super.key});
  final _formKey = GlobalKey<FormBuilderState>();

  List<Map<String, dynamic>> questionData = [
    {
      "name": "Input",
      "label": "Label",
      "widget": "TextField",
      "required": true
    },
    {
      "name": "checkbox",
      "label": "Label",
      "widget": "CheckboxGroup",
      "options": ["Dart", "Kotlin", "Java", "Swift", "Objective-C"],
      "required": true
    },
    {
      "name": "Radio",
      "label": "Label",
      "widget": "RadioGroup",
      "options": ["Dart", "Kotlin", "Java", "Swift", "Objective-C"],
      "required": true
    },
    {
      "name": "date",
      "type": "date",
      "label": "Label",
      "widget": "DateTimePicker",
      "required": true
    }
  ];

  late List<Question> questionList =
      questionData.map((e) => Question.fromJson(e)).toList();

  List<Widget> generateForm(List<Question> questionList) {
    List<Widget> list = [];
    for (var q in questionList) {
      String questionWidget = q.widget;
      switch (questionWidget) {
        case "TextField":
          {
            list.add(generateTextField(q));
          }
          break;

        case "CheckboxGroup":
          {
            list.add(generateCheckboxGroup(q));
          }
          break;

        case "RadioGroup":
          {
            list.add(generateRadioGroup(q));
          }
          break;

        case "DateTimePicker":
          {
            list.add(generateDateTimePicker(q));
          }
          break;
      }
    }

    list.add(
      ElevatedButton(
          onPressed: () {
            final isValid = _formKey.currentState?.validate();
            if (isValid != null && isValid) {
              _formKey.currentState?.save();
            }
          },
          child: const Text("Submit")),
    );
    return list;
  }

  FormBuilderTextField generateTextField(Question question) {
    final text = useState("");
    return FormBuilderTextField(
      name: question.name,
      decoration: InputDecoration(labelText: question.label),
      validator: question.required ? FormBuilderValidators.required() : null,
      onSaved: (newValue) => text.value = newValue!,
    );
  }

  FormBuilderCheckboxGroup generateCheckboxGroup(Question question) {
    final options = useState([]);
    return FormBuilderCheckboxGroup(
      name: question.name,
      options: question.options!
          .map((e) => FormBuilderFieldOption(value: e))
          .toList(),
      decoration: InputDecoration(labelText: question.label),
      validator: question.required ? FormBuilderValidators.required() : null,
      onSaved: (newValue) => options.value = newValue!,
    );
  }

  FormBuilderRadioGroup generateRadioGroup(Question question) {
    final options = useState([]);
    return FormBuilderRadioGroup(
      name: question.name,
      options: question.options!
          .map((e) => FormBuilderFieldOption(value: e))
          .toList(),
      decoration: InputDecoration(labelText: question.label),
      validator: question.required ? FormBuilderValidators.required() : null,
      onSaved: (newValue) => options.value = newValue!,
    );
  }

  FormBuilderDateTimePicker generateDateTimePicker(Question question) {
    final date = useState(DateTime(0));
    return FormBuilderDateTimePicker(
      name: question.name,
      inputType: InputType.date,
      decoration: InputDecoration(labelText: question.label),
      validator: question.required ? FormBuilderValidators.required() : null,
      onSaved: (newValue) => date.value = newValue!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: generateForm(questionList),
        ),
      ),
    );
  }
}
