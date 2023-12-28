class BookModel {
  final int id;
  final String isbn;
  final String title;
  final String author;
  final DateTime publishedDate;
  final String publisher;
  final int pageCount;
  final String image;

  BookModel({
    required this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.publisher,
    required this.pageCount,
    required this.image,
  });
}
