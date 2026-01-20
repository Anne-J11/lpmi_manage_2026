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

  Future<void> addOffer(Offer offer) async {
    await _repository.insertOffer(offer);
    await getOffers();
  }

  Future<void> deleteOfferById(int id) async {
    await _repository.deleteOfferById(id);
    offers.removeWhere((offer) => offer.id == id);
    notifyListeners();
  }

  Future<void> updateOfferById(Offer offer) async {
    await _repository.updateOfferById(offer);
    await getOffers();
  }

  String? validateOffer(String title, String description, String time, String location) {
    if (title.trim().isEmpty) return "Le titre est obligatoire";
    if (description.trim().isEmpty) return "La description est obligatoire";
    if (int.tryParse(time) == null || int.parse(time) <= 0) {
      return "La durée doit être un nombre positif";
    }
    if (location.trim().isEmpty) return "Le lieu est obligatoire";
    return null;
  }

  void logout() {
    offers = [];
    notifyListeners();
  }
}
