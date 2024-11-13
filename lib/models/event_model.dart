class EventModel {
  final String title;
  final DateTime startTimestamp;
  final String location;
  final bool isShown;
  final bool isHeadline;
  final bool hasCountdown;
  final String? headlineTitle;
  final String? summary;
  final String? imageUrl;
  final int? parentId;

  const EventModel(
    this.title,
    this.startTimestamp,
    this.location,
    this.isShown,
    this.isHeadline,
    this.hasCountdown,
    this.headlineTitle,
    this.summary,
    this.imageUrl,
    this.parentId
  );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'startTimestamp': int startTimestamp,
        'location': String location,
        'isShown': int isShown,
        'isHeadline': int isHeadline,
        'hasCountdown': int hasCountdown,
        'headlineTitle': String? headlineTitle,
        'summary': String? summary,
        'imageUrl': String? imageUrl,
        'parentId': int? parentId
      } => EventModel(title, DateTime.fromMillisecondsSinceEpoch(startTimestamp * 1000, isUtc: true), location, isShown == 1, isHeadline == 1, hasCountdown == 1, headlineTitle, summary, imageUrl, parentId),
      _ => throw const FormatException("Failed to load event.")
    };
  }
}