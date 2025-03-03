// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:news_application/model/news_model.dart';
//
// class DBHelper {
//   static Database? _database;
//
//   /// ✅ Initialize Database
//   static Future<Database> getDatabase() async {
//     if (_database != null) return _database!;
//
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'news_history.db');
//
//     _database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE news(
//             id TEXT PRIMARY KEY,
//             title TEXT,
//             description TEXT,
//             url TEXT,
//             imageUrl TEXT
//           )
//         ''');
//       },
//     );
//     return _database!;
//   }
//
//   /// ✅ Insert News Article into Database
//   static Future<void> insertNews(NewsModel news) async {
//     final db = await getDatabase();
//     await db.insert(
//       'news',
//       news.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   /// ✅ Fetch All Saved News
//   static Future<List<NewsModel>> getSavedNews() async {
//     final db = await getDatabase();
//     final List<Map<String, dynamic>> maps = await db.query('news');
//
//     return List.generate(maps.length, (i) {
//       return NewsModel.fromMap(maps[i]);
//     });
//   }
//
//   /// ✅ Delete News by ID
//   static Future<void> deleteNews(String id) async {
//     final db = await getDatabase();
//     await db.delete('news', where: 'id = ?', whereArgs: [id]);
//   }
//
//   /// ✅ Clear Reading History
//   static Future<void> clearHistory() async {
//     final db = await getDatabase();
//     await db.delete('news');
//   }
// }
