import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_offer.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/screen/offer_screen.dart';
import 'package:lpmi_manage/screen/welcome_screen.dart';
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

  void _logout(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    homeController.logout();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text('Se déconnecter', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offres disponibles"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () => _showLogoutConfirmation(context),
          ),
        ],
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
            MaterialPageRoute(builder: (context) => const OfferScreen()),
          );
        },
        tooltip: "Ajouter une offre",
        child: const Icon(Icons.add),
      ),
    );
  }
}
