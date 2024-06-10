import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wiltguard/controllers/user_controller.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

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
        child: feed(context),
      ),
    );
  }

  Widget feed(BuildContext context) {
    // Example data structure for an article
    final List<Article> articles = [
      Article(
          title: 'Planting Coffee Seeds',
          subtitle: 'Starting Strong with Coffee Seeds',
          content:
              'Coffee cultivation begins with selecting high-quality seeds. Plant them in well-drained soil, ideally in a nursery bed, keeping them moist and warm. Germination usually takes 2-3 months. Regular watering and protection from pests are crucial during this stage.',
          date: "2/3/24"),
      Article(
          title: 'Nurturing Young Coffee Plants',
          subtitle: 'Growing Up: Caring for Young Coffee Plants',
          content:
              'TOnce sprouted, young coffee plants require careful attention. Transplant them into larger pots or directly into the ground, ensuring they receive plenty of sunlight. Fertilize monthly with organic compost to promote healthy growth. Pruning helps shape the plant and encourages fruit production.',
          date: "12/3/24"),
      Article(
          title: 'Harvesting Coffee Cherries',
          subtitle: 'ime to Pick: Harvesting Coffee Cherries',
          content:
              'Harvesting is a meticulous process. Coffee cherries are ready when they turn bright red. Hand-picking ensures quality, though mechanical methods are faster. Timing is critical; pick too early, and the beans are underdeveloped, too late, and they lose flavor.',
          date: "6/4/24"),
    ];

    return ListView.builder(
      itemCount:
          articles.length + 1, // Adjust itemCount to accommodate the Divider
      itemBuilder: (context, index) {
        if (index >= articles.length) {
          // Check if it's the last item
          return SizedBox(
              height: 0); // Return an empty SizedBox for the last divider
        }
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background
              ),
              child: ListTile(
                title: Text(
                  articles[index].title,
                  style: TextStyle(color: Colors.green), // Green text color
                ),
                subtitle: Text(articles[index].subtitle),
                trailing: Text(articles[index].date),
                onTap: () => _showDialog(context, articles[index]),
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
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
  final String title;
  final String subtitle;
  final String content;
  final String date;
  Article(
      {required this.title,
      required this.subtitle,
      required this.content,
      required this.date});
}
