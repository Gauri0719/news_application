import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_application/model/news_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'reading_history';

  // Singleton Pattern
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  // Initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final String path = join(await getDatabasesPath(), 'news_history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            url TEXT,
            imageUrl TEXT,
            source TEXT,
            publishedAt TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  // Insert news into database
  Future<int> insertNews(NewsModel news) async {
    final db = await database;
    return await db.insert(tableName, news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Fetch all saved news
  Future<List<NewsModel>> getSavedNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    print("Fetching history: ${maps.length} records found"); // Debugging
    for (var map in maps) {
      print("DB Record: ${map['title']}"); // Print each record fetched
    }

    return List.generate(maps.length, (i) => NewsModel.fromMap(maps[i]));
  }


  // Delete all saved news
  Future<void> clearHistory() async {
    final db = await database;
    await db.delete(tableName);
  }
}