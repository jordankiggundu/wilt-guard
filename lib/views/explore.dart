import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiltguard/controllers/user_controller.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends State<Explore> {
  late Future<List<Article>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            Provider.of<UserController>(context, listen: false)
                .setCurrentUser(null);
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Knowledge Base, Articles, and more',
          style: TextStyle(
            color: Color(0xFF9098B1),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0.12,
            letterSpacing: 0.50,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Article>>(
          future: futureArticles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: ListTile(
                          title: Text(
                            snapshot.data![index].title,
                            style: const TextStyle(color: Colors.green),
                          ),
                          subtitle: Text(snapshot.data![index].description),
                          trailing: Text(snapshot.data![index].publishedAt),
                          onTap: () =>
                              _showDialog(context, snapshot.data![index]),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=agriculture&from=2024-06-01&to=2024-06-10&sortBy=popularity&apiKey=8684f18e16c14603b1d7cc099f81773b'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List jsonResponse = json.decode(response.body)['articles'];
      return jsonResponse.map((article) => Article.fromMap(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  void _showDialog(BuildContext context, Article article) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(article.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(article.content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Article {
  final String? source;
  final String? author;
  final String title;
  final String description;
  final String? url;
  final String? urlToImage;
  final String publishedAt;
  final String content;

  Article({
    this.source,
    this.author,
    required this.title,
    required this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromMap(Map<String, dynamic> json) {
    return Article(
      source: json['source']['name'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
