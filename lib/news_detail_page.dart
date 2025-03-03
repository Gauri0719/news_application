import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> news = Get.arguments; // Getting news data

    // Function to open the news URL in the browser
    void _launchURL() async {
      final Uri url = Uri.parse(news['url']);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        Get.snackbar("Error", "Could not open the link",
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(news['source'] ?? 'Unknown Source'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share("${news['title']} - Read more at ${news['url']}");
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
            news['imageUrl'] != null
                ? Image.network(news['imageUrl'], fit: BoxFit.contain)
                : SizedBox(),

            SizedBox(height: 10),

            // News Title
            Text(
              news['title'] ?? 'No Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Published Date & Read More Button
            Row(
              children: [
                Text(
                  news['publishedAt'] ?? '',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Spacer(),
                TextButton(
                  onPressed: _launchURL,
                  child: Text(
                    "Read More",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // News Description
            Text(
              news['description'] ?? 'No description available',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 10),

            // Full News Content
            Text(
              news['content'] ?? '',
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
