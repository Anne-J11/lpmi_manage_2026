import 'package:flutter/material.dart';
import 'package:lpmi_manage/model/offer.dart';

class CustomOffer extends StatelessWidget {
  final Offer offer;
  const CustomOffer({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(offer.title),

          SizedBox(
            height: 50,
            child: Text(
              offer.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${offer.startDate.day}/${offer.startDate.month}/${offer.startDate.year}",
                  ),
                ),
                Expanded(
                  child: Text(
                    offer.time.toString(),
                  ),
                ),
                Expanded(
                  child: Text(offer.location),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
