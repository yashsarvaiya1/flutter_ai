class Message {
  String? role;
  String? message;

  Message({this.role, this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(role: json['role'], message: json['response']);
  }

  Map<String, dynamic> toJson() {
    return {'role': role, 'message': message};
  }
}
