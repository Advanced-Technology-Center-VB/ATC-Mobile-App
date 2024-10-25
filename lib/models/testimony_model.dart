class TestimonyModel {
  final String studentName;
  final int yearsAttended;
  final String statement;

  const TestimonyModel(this.studentName, this.yearsAttended, this.statement);

  factory TestimonyModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'studentName': String studentName,
        'yearsAttended': int yearsAttended,
        'statement': String statement
      } => TestimonyModel(studentName, yearsAttended, statement),
      _ => throw const FormatException("Failed to load testimonies")
    };
  }
}