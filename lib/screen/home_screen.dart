import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_offer.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/screen/add_offer_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});





  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(
      context,
      listen: true,
    );
    homeController.getOffers();

    return Scaffold(
      appBar: AppBar(
        title: Text("Offres disponibles"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: homeController.offers.length,
        itemBuilder: (context, index) {
          return CustomOffer(
            offer: homeController.offers[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AddOfferScreen()));}, tooltip: "Ajouter une offre", child: const Icon(Icons.add),),
    );
  }
}


