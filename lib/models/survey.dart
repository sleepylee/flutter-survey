class Survey {
  String cursor;
  String id;
  String title;
  String description;
  String coverImageUrl;

  Survey(
      {required this.cursor,
      required this.id,
      required this.title,
      required this.description,
      required this.coverImageUrl});

  String get hdCoverImageUrl => coverImageUrl + "l";
}
