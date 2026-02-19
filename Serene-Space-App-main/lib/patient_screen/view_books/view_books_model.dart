class Book {
  final int id;
  final String title;
  final String author;
  final String description;
  final String category;
  final String publisher;
  final String publicationDate;
  final String coverImage;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.category,
    required this.publisher,
    required this.publicationDate,
    required this.coverImage,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
   return Book(
 id: json['id'],
 title: json['title'],
 author: json['author'],
 description: json['description'],
 category: json['category'],
 publisher: json['publisher'],
 publicationDate: json['publication_date'],
 coverImage: json['cover_image'],
 );
  }
}
