import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final news = Get.arguments; // Getting news data

    // Function to open the news URL in the browser
    void _launchURL() async {
      final Uri url = Uri.parse(news['url']);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Could not open the link",
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(news['source']),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Implement sharing functionality here (Optional)
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
                ? Image.network(news['imageUrl'], fit: BoxFit.cover)
                : SizedBox(),

            SizedBox(height: 10),

            // News Title
            Text(
              news['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Published Date
            Text(
              news['publishedAt'],
              style: TextStyle(fontSize: 14, color: Colors.grey),
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

            // Read More Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _launchURL,
                child: Text("Read More", style: TextStyle(fontSize: 16, color: Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
