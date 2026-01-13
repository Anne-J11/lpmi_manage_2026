import 'package:flutter/material.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:lpmi_manage/repository/offer_repository.dart';
import 'package:lpmi_manage/screen/home_screen.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({super.key});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final OfferRepository _repository = OfferRepository();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final DateTime _startDate = DateTime.now();
  final _locationController = TextEditingController();

  Future<void> saveOffer() async {
    final offer = Offer(
      id: DateTime.now().microsecondsSinceEpoch,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      time: int.tryParse(_timeController.text.trim()) ??0,
      startDate: _startDate,
      location: _locationController.text.trim(),
    );
    print('++save -> $offer');

    await _repository.insertOffer(offer);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une offre"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Titre de l'offre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez entrer un titre";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description de l'offre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez entrer une description.";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: "Début de l'offre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.date_range),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez entrer une date";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: "Durée de l'offre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez entrer une durée";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: "Lieu de l'offre",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Veuillez entrer un lieu";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                print("chat");
                await saveOffer();
                Navigator.pop(context);
              },
              child: const Text("Ajouter l'offre"),
            ),
          ],
        ),
      ),
    );
  }
}
