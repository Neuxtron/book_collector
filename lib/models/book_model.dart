class BookModel {
  final int? id;
  final String isbn;
  final String title;
  final String series;
  final String author;
  final DateTime publishedDate;
  final String publisher;
  final int pageCount;
  final String image;
  final String description;

  BookModel({
    this.id,
    required this.isbn,
    required this.title,
    required this.series,
    required this.author,
    required this.publishedDate,
    required this.publisher,
    required this.pageCount,
    required this.image,
    required this.description,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"],
      isbn: json["isbn"],
      title: json["title"],
      series: json["subtitle"] ?? "",
      author: json["author"] ?? "",
      publishedDate: DateTime.parse(json["published"]),
      publisher: json["publisher"] ?? "",
      pageCount: json["pages"] ?? 0,
      image: json["website"] ?? "",
      description: json["description"] ?? "",
    );
  }
}
