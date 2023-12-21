class MemoModel{
  int id; // memo id
  String title; // 제목
  String content; // 내용
  dynamic createdAt;  // 작성시각

  MemoModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

// toJson 메서드: MemoModel을 JSON으로 직렬화
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  // fromJson 메서드: JSON을 MemoModel로 역직렬화
  factory MemoModel.fromJson(Map<String, dynamic> json) {
    return MemoModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}