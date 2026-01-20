import 'package:flutter/foundation.dart';
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
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(tableName, orderBy: 'startDate DESC');
      return List.generate(maps.length, (i) => Offer.fromMap(maps[i]));
    } catch (e) {
      debugPrint('Erreur getAllOffers: $e');
      return []; // Ou rethrow selon la stratégie
    }
  }

  Future<void> deleteOfferById(int id) async {
    final db = await _dbHelper.database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateOfferById(Offer offer) async {
    final db = await _dbHelper.database;
    await db.update(
      tableName,
      offer.toMap(),
      where: 'id = ?',
      whereArgs: [offer.id],
    );
  }
}
