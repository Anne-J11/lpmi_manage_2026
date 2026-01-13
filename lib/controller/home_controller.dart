import 'package:flutter/cupertino.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:lpmi_manage/repository/offer_repository.dart';

class HomeController extends ChangeNotifier {

  List<Offer> offers = [];

  Future<void> getOffers() async{
    offers = await OfferRepository().getAllOffers();
    notifyListeners();
  }
}