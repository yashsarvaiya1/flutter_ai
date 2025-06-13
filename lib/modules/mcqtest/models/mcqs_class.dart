import 'package:api_demo/modules/mcqtest/models/question_class.dart';

class McqsClass {
  List<Question>? questions;
  int score;
  List<String>? selectedOptions;

  McqsClass({this.questions, this.selectedOptions, this.score = 0});

  factory McqsClass.fromJson(Map<String, dynamic> json) {
    return McqsClass(
      questions: (json['questions'] as List)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      score: json['score'] ?? 0,
      selectedOptions: json['selectedOptions'] != null
          ? List<String>.from(json['selectedOptions'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((q) => q.toJson()).toList(),
      'score': score,
      'selectedOptions': selectedOptions,
    };
  }
}
