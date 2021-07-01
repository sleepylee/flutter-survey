class Survey {
  String cursor;
  String id;
  String title;
  String description;
  String coverImageUrl;

  Survey(
      {this.cursor, this.id, this.title, this.description, this.coverImageUrl});

  String get hdCoverImageUrl => coverImageUrl + "l";
}
