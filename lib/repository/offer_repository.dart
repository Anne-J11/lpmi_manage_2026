import 'package:lpmi_manage/database/database_helper.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:sqflite/sqflite.dart';

class OfferRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  static const String tableName = 'offers';

  Future<void> insertOffer(Offer offer) async {
    final db = await _dbHelper.database;
    await db.insert(
      tableName,
      offer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Offer>> getAllOffers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      orderBy: 'startDate DESC',
    );


    return List.generate(maps.length, (i) {
      return Offer.fromMap(maps[i]);
    });
  }
}
