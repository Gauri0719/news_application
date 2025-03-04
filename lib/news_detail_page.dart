import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/date.dart';
import 'package:news_application/services/database_class.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_application/model/news_model.dart'; // Import the model

class NewsDetailPage extends StatefulWidget {
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  late NewsModel news;

  @override
  void initState() {
    super.initState();
    news = Get.arguments as NewsModel;
    _saveNewsToDatabase(news); // Save news only once when page loads
  }

  void _saveNewsToDatabase(NewsModel news) async {
    await _dbHelper.insertNews(news);
    print("News saved to database: ${news.title}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(news.source),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share("${news.title} - Read more at ${news.url}");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            news.imageUrl.isNotEmpty
                ? Image.network(news.imageUrl, fit: BoxFit.contain)
                : SizedBox(),

            SizedBox(height: 10),

            Text(
              news.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Text(
                  formatToISTDate(news.publishedAt),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Spacer(),
                TextButton(
                  onPressed: () => _launchURL(news.url),
                  child: Text("Read More", style: TextStyle(fontSize: 16, color: Colors.blue)),
                ),
              ],
            ),

            SizedBox(height: 10),

            Text(
              news.description ?? 'No description available',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),

            Text(
              news.content ?? '',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch $url");
        Get.snackbar("Error", "Could not open the link",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
      Get.snackbar("Error", "Invalid URL", snackPosition: SnackPosition.BOTTOM);
    }
  }
}
