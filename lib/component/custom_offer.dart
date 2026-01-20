import 'package:flutter/material.dart';
import 'package:lpmi_manage/controller/home_controller.dart';
import 'package:lpmi_manage/model/offer.dart';
import 'package:lpmi_manage/screen/offer_screen.dart';
import 'package:lpmi_manage/screen/offer_detail_screen.dart';
import 'package:provider/provider.dart';

class CustomOffer extends StatelessWidget {
  final Offer offer;

  const CustomOffer({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferDetailScreen(offer: offer),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(offer.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                offer.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfo(
                      context,
                      Icons.calendar_today,
                      "${offer.startDate.day}/${offer.startDate.month}/${offer.startDate.year}"),
                  _buildInfo(context, Icons.timer, "${offer.time} jours"),
                  _buildInfo(context, Icons.location_on, offer.location),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: 'Modifier',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfferScreen(offer: offer),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Supprimer',
                    onPressed: () => _showDeleteConfirmation(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: Colors.grey[800])),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cette offre ?'),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Provider.of<HomeController>(context, listen: false)
                    .deleteOfferById(offer.id);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
