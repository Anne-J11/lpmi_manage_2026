import 'package:flutter/material.dart';
import 'package:lpmi_manage/model/offer.dart';

class OfferDetailScreen extends StatelessWidget {
  final Offer offer;

  const OfferDetailScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offer.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              offer.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Divider(height: 32),
            _buildInfoRow(context, Icons.calendar_today, 'Début : ${offer.startDate.day}/${offer.startDate.month}/${offer.startDate.year}'),
            const SizedBox(height: 8),
            _buildInfoRow(context, Icons.timer, 'Durée : ${offer.time} jours'),
            const SizedBox(height: 8),
            _buildInfoRow(context, Icons.location_on, 'Lieu : ${offer.location}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
