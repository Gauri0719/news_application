import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_application/model/news_model.dart'; // Import the model

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsModel news = Get.arguments as NewsModel; // Cast to NewsModel

    // Function to open the news URL in the browser
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
            // News Image
            news.imageUrl != null
                ? Image.network(news.imageUrl, fit: BoxFit.contain)
                : SizedBox(),

            SizedBox(height: 10),

            // News Title
            Text(
              news.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Published Date
            Row(
              children: [
                Text(
                  news.publishedAt,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Spacer(),
                TextButton(
                  onPressed: ()=> _launchURL(news.url),
                  child: Text("Read More", style: TextStyle(fontSize: 16, color: Colors.blue)),
                ),
              ],
            ),

            SizedBox(height: 10),

            // News Description
            Text(
              news.description ?? 'No description available',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),

            // Full News Content
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
}
