import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:serene_space_project/patient_screen/view_books/view_books_model.dart';
import 'package:serene_space_project/constant_uri.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(
      Uri.parse(
        '${baseUrl}userapp/user_view_book/',
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
  //  final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4FF),
      appBar: AppBar(
        title: const Text(
          "Books",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.deepPurple,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: FutureBuilder<List<Book>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final books = snapshot.data!;

            if (books.isEmpty) {
              return const Center(
                child: Text(
                  "No books available",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Row(
                      children: [
                        // Book Cover Image
                        Container(
                          width: 92,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                '${baseUrl}${book.coverImage.startsWith('/') ? book.coverImage.substring(1) : book.coverImage}',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        // Book Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF333652),
                                        fontSize: 18,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "by ${book.author}",
                                  style: TextStyle(
                                    color: Color(0xFF8568CF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDF1FA),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    book.category,
                                    style: TextStyle(
                                      color: Color(0xFF6593EA),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to fetch books',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          );
        },
      ),
    );
  }
}
