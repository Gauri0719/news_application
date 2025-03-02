import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;

  const NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
        actions: [
          IconButton(onPressed: (){
            Share.share("${news.title}\nRead more : ${news.url}");
          },
              icon: Icon(Icons.share),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            news.image.isNotEmpty
            ? Image.network(news.image,fit: BoxFit.cover,width: double.infinity,height: 250,)
                : Container(height: 250,color: Colors.grey,),
            Padding(padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(news.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(news.description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 15),
                Text("Source: ${news.source}", style: TextStyle(fontSize: 14, color: Colors.blue)),
                SizedBox(height: 10),
                Text("Published At: ${news.publishedAt}", style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(news.url);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      Get.snackbar("Error", "Could not launch URL");
                    }
                  },
                  child: Text("Read More"),
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
