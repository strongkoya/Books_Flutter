import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Book {
  final String title;
  final String coverImagePath;
  final String author;
  final String description;
  final double price;

  const Book({
    required this.title,
    required this.coverImagePath,
    required this.author,
    required this.description,
    required this.price,
  });
}

final books = [
  Book(
    title: 'Livre 1',
    coverImagePath: 'assets/images/livre1.jpg',
    author: 'Auteur 1',
    description: 'Description du livre 1',
    price: 9.99,
  ),
  Book(
    title: 'Livre 2',
    coverImagePath: 'assets/images/livre2.jpg',
    author: 'Auteur 2',
    description: 'Description du livre 2',
    price: 12.99,
  ),
  Book(
    title: 'Livre 3',
    coverImagePath: 'assets/images/livre3.jpg',
    author: 'Auteur 3',
    description: 'Description du livre 3',
    price: 14.99,
  ),
  Book(
    title: 'Livre 4',
    coverImagePath: 'assets/images/livre4.jpg',
    author: 'Auteur 4',
    description: 'Description du livre 4',
    price: 11.99,
  ),
  Book(
    title: 'Livre 5',
    coverImagePath: 'assets/images/livre5.jpg',
    author: 'Auteur 5',
    description: 'Description du livre 5',
    price: 10.99,
  ),
];
List<Book> livresCommandes = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste des livres',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste des livres'),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsPage(book: books[index]),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        books[index].coverImagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            books[index].title,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            books[index].author,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            books[index].description,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$${books[index].price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LivreCommande {
  final Book livre;
  int quantite;

  LivreCommande({required this.livre, this.quantite = 1});
}

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              book.coverImagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    book.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // CommandePage commandePage = new CommandePage(livresCommandes: livresCommandes)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommandePage(
                                      livresCommandes: [book],
                                    )),
                          );
                        },
                        child: Text(
                            'Commander (\$${book.price.toStringAsFixed(2)})'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class CommandePage extends StatelessWidget {
  final List<Book> livresCommandes;

  const CommandePage({Key? key, required this.livresCommandes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _qte = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Commande'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Commande',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: livresCommandes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    livresCommandes[index].coverImagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(livresCommandes[index].title),
                  subtitle: Text(livresCommandes[index].author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _qte++;
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text('$_qte'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Valider'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Retourner'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/

class CommandePage extends StatefulWidget {
  final List<Book> livresCommandes;

  const CommandePage({Key? key, required this.livresCommandes})
      : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  int _qte = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commande'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Commande',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.livresCommandes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(
                    widget.livresCommandes[index].coverImagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(widget.livresCommandes[index].title),
                  subtitle: Text(widget.livresCommandes[index].author),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_qte > 0) _qte--;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text('$_qte'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _qte++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Ajouter la logique pour valider la commande
                    },
                    child: Text('Valider'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Retourner'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
