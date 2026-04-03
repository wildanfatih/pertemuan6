import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BookListScreen(),
  ));
}

class BookListScreen extends StatelessWidget {
  // Hapus kata 'const' di depan List agar tidak error
  final List<Map<String, String>> books = [
    {
      'title': 'Algorithms to Live By',
      'author': 'Brian Christian',
      'description': 'How algorithms developed for computers untangle human questions.'
    },
    {
      'title': 'Beginning Programming for Dummies',
      'author': 'Wallace Wang',
      'description': 'Decide what you want your program to do and turn instructions into machine language.'
    },
    {
      'title': 'Streamlit for Data Science',
      'author': 'Tyler Richards',
      'description': 'Create and deploy data apps quickly within Python.'
    },
    {
      'title': 'Clean Code',
      'author': 'Robert C. Martin',
      'description': 'A handbook of agile software craftsmanship.'
    },
    {
      'title': 'The Pragmatic Programmer',
      'author': 'Andrew Hunt',
      'description': 'From personal responsibility to career development.'
    },
    {
      'title': 'Design Patterns',
      'author': 'Erich Gamma',
      'description': 'Elements of Reusable Object-Oriented Software.'
    },
    {
      'title': 'Flutter in Action',
      'author': 'Eric Windmill',
      'description': 'Build professional-quality mobile applications.'
    },
    {
      'title': 'Introduction to Algorithms',
      'author': 'Thomas H. Cormen',
      'description': 'Comprehensive guide to the modern study of computer algorithms.'
    },
    {
      'title': 'Refactoring',
      'author': 'Martin Fowler',
      'description': 'Improving the design of existing code.'
    },
    {
      'title': 'Artificial Intelligence',
      'author': 'Stuart Russell',
      'description': 'Modern approach to the theory and practice of AI.'
    },
  ];

  BookListScreen({super.key}); // Hapus 'const' di sini juga

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book List')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.book),
            title: Text(books[index]['title']!),
            subtitle: Text(books[index]['author']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(
                    title: books[index]['title']!,
                    author: books[index]['author']!,
                    description: books[index]['description']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  final String title;
  final String author;
  final String description;

  const BookDetailScreen({
    super.key,
    required this.title,
    required this.author,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('By $author', style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            const Divider(height: 30),
            const Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadingBookFile(bookTitle: title),
                      ),
                    );
                  },
                  child: const Text('Read the book'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ReadingBookFile extends StatelessWidget {
  final String bookTitle; // Ini "wadah" untuk judul buku
  
  // Ini constructor untuk menerima data judul
  const ReadingBookFile({super.key, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading: $bookTitle')),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      ),
    );
  }
}