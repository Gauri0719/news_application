import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_application/model/news_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'news_detail_page.dart';

class ReadingHistoryPage extends StatefulWidget {
  @override
  _ReadingHistoryPageState createState() => _ReadingHistoryPageState();
}

class _ReadingHistoryPageState extends State<ReadingHistoryPage> {
  List<NewsModel> history = [];
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase().then((_) => loadHistory());
  }

  // Initialize Database
  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'news_history.db'),
      version: 1,
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
    );
  }

  // Fetch All History
  Future<void> loadHistory() async {
    final List<Map<String, dynamic>> maps = await _database.query('reading_history');
    setState(() {
      history = maps.map((news) => NewsModel.fromJson(news)).toList();
    });
  }

  // Clear All History
  Future<void> clearHistory() async {
    await _database.delete('reading_history');
    setState(() {
      history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reading History"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: clearHistory,
          ),
        ],
      ),
      body: history.isEmpty
          ? Center(child: Text("No reading history available"))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final news = history[index];

          return ListTile(
            leading: news.image.isNotEmpty
                ? Image.network(news.image, width: 80, height: 80, fit: BoxFit.cover)
                : Container(width: 80, height: 80, color: Colors.grey),
            title: Text(news.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(news.source),
            onTap: () => Get.to(() => NewsDetailPage(news: news)),
            onLongPress: () async {
              await _database.delete('reading_history', where: 'id = ?', whereArgs: [news.id]);
              loadHistory();
            },
          );
        },
      ),
    );
  }
}
