import 'package:flutter/material.dart';
import 'package:lpmi_manage/component/custom_offer.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/model/fake_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offres disponibles"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: HomeController().listSize,
        itemBuilder: (context, index) {
          return CustomOffer(
            offer: myOffers[index],
          );
        },
      ),
    );
  }
}
