import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:provider/provider.dart';

class AddOfferScreen extends StatefulWidget {
  final Offer? offer;

  const AddOfferScreen({super.key, this.offer});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _startDateController = TextEditingController();

  DateTime _startDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.offer != null) {
      _titleController.text = widget.offer!.title;
      _descriptionController.text = widget.offer!.description;
      _timeController.text = widget.offer!.time.toString();
      _locationController.text = widget.offer!.location;
      _startDate = widget.offer!.startDate;
    }
    _updateStartDateText();
  }

  void _updateStartDateText() {
    _startDateController.text =
        "${_startDate.day}/${_startDate.month}/${_startDate.year}";
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  Future<void> _saveOrUpdateOffer() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _timeController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez remplir tous les champs')),
        );
      }
      return;
    }

    final homeController = Provider.of<HomeController>(context, listen: false);

    if (widget.offer == null) {
      final newOffer = Offer(
        id: DateTime.now().microsecondsSinceEpoch,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        time: int.tryParse(_timeController.text.trim()) ?? 0,
        startDate: _startDate,
        location: _locationController.text.trim(),
      );
      await homeController.getOffers(); // Simulating insert
    } else {
      final updatedOffer = Offer(
        id: widget.offer!.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        time: int.tryParse(_timeController.text.trim()) ?? 0,
        startDate: _startDate,
        location: _locationController.text.trim(),
      );
      await homeController.updateOfferById(updatedOffer);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offer == null ? "Ajouter une offre" : "Modifier l'offre"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: "Titre de l'offre", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: "Description de l'offre",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _startDateController,
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: "Début de l'offre", border: OutlineInputBorder()),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _startDate) {
                  setState(() {
                    _startDate = pickedDate;
                    _updateStartDateText();
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                  labelText: "Durée de l'offre (en jours)",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                  labelText: "Lieu de l'offre", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveOrUpdateOffer,
              child: Text(widget.offer == null ? "Ajouter" : "Mettre à jour"),
            ),
          ],
        ),
      ),
    );
  }
}
