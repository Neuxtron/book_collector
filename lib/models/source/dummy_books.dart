import 'package:book_collector/models/book_model.dart';

class DummyBooks {
  static final singleBook = BookModel(
    id: 1,
    isbn: "9780747532699",
    title: "Harry Potter and the Philosopher's Stone",
    author: "J. K. Rowling",
    publishedDate: DateTime(1997, 6, 26),
    publisher: "Bloomsbury",
    pageCount: 223,
    image:
        "https://m.media-amazon.com/images/I/81Fyh2mrw4L._AC_UF1000,1000_QL80_.jpg",
  );

  static final allBooks = [
    singleBook,
    singleBook,
    singleBook,
    singleBook,
    singleBook,
    singleBook,
    singleBook,
  ];
}
