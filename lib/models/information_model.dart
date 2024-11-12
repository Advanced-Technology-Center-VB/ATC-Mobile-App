class InformationModel {
  final String applicationUrl;
  final DateTime applicationDeadline;
  final DateTime applicationLateDeadline;
  final List<String> applicationChecklist;

  const InformationModel(this.applicationUrl, this.applicationDeadline, this.applicationLateDeadline, this.applicationChecklist);

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "application_url": String applicationUrl,
        "application_deadline": int applicationDeadline,
        "application_late_deadline": int applicationLateDeadline,
        "application_checklist": List<dynamic> applicationChecklist
      } => InformationModel(
        applicationUrl, 
        DateTime.fromMillisecondsSinceEpoch(applicationDeadline * 1000).toUtc(), 
        DateTime.fromMillisecondsSinceEpoch(applicationLateDeadline * 1000).toUtc(),
        applicationChecklist.cast<String>()
      ),
      _ => throw Exception("Cannot load information data.")
    };
  }
}