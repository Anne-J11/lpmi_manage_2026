import 'package:flutter/cupertino.dart';
import 'package:lpmi_manage/model/fake_data.dart';
import 'package:lpmi_manage/model/offer.dart';

class HomeController extends ChangeNotifier{
  final listSize = myOffers.length;

  Future<List<Offer>> getOffers() async {
    await Future.delayed(const Duration(seconds: 2));
    notifyListeners();
    return myOffers;
  }
}