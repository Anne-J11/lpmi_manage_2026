import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_offer.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/screen/add_offer_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).getOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offres disponibles"),
        centerTitle: true,
      ),
      body: Consumer<HomeController>(
        builder: (context, homeController, child) {
          return ListView.builder(
            itemCount: homeController.offers.length,
            itemBuilder: (context, index) {
              return CustomOffer(offer: homeController.offers[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddOfferScreen()),
          );
        },
        tooltip: "Ajouter une offre",
        child: const Icon(Icons.add),
      ),
    );
  }
}
