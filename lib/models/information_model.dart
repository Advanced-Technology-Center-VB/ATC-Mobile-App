class InformationModel {
  final String applicationUrl;
  final DateTime applicationDeadline;
  final DateTime applicationLateDeadline;

  const InformationModel(this.applicationUrl, this.applicationDeadline, this.applicationLateDeadline);

  factory InformationModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "application_url": String applicationUrl,
        "application_deadline": int applicationDeadline,
        "application_late_deadline": int applicationLateDeadline
      } => InformationModel(
        applicationUrl, 
        DateTime.fromMillisecondsSinceEpoch(applicationDeadline * 1000).toUtc(), 
        DateTime.fromMillisecondsSinceEpoch(applicationLateDeadline * 1000).toUtc()
      ),
      _ => throw Exception("Cannot load information data.")
    };
  }
}