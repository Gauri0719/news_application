import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
// import '../model/news_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;

  NewsDetailPage({required this.news}) {
    saveToHistory();
  }

  // Initialize Database
  Future<Database> _getDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'news_history.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE reading_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            url TEXT,
            image TEXT,
            source TEXT,
            publishedAt TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Save Opened News to History
  Future<void> saveToHistory() async {
    final db = await _getDatabase();
    await db.insert(
      'reading_history',
      news.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share("${news.title} - Read more at ${news.url}");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            news.image.isNotEmpty
                ? Image.network(news.image, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey),
            SizedBox(height: 10),
            Text(news.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(news.description),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(news.source, style: TextStyle(color: Colors.blue)),
                Text(news.publishedAt, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (await canLaunch(news.url)) {
                  await launch(news.url);
                } else {
                  Get.snackbar("Error", "Cannot open news link");
                }
              },
              child: Text("Read More"),
            ),
          ],
        ),
      ),
    );
  }
}
