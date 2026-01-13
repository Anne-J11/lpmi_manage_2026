import 'package:flutter/cupertino.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:lpmi_manage/repository/offer_repository.dart';

class HomeController extends ChangeNotifier {
  final OfferRepository _repository = OfferRepository();
  List<Offer> offers = [];

  Future<void> getOffers() async {
    offers = await _repository.getAllOffers();
    notifyListeners();
  }

  Future<void> deleteOfferById(int id) async {
    await _repository.deleteOfferById(id);
    await getOffers();
  }

  Future<void> updateOfferById(Offer offer) async {
    await _repository.updateOfferById(offer);
    await getOffers();
  }
}
