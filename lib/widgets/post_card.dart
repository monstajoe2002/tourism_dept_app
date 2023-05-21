import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostCard extends StatefulWidget {
  String title;
  String location;
  String imageUrl;
  String category;
  double? rating;
  PostCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.category,
    this.rating,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

void onRatingUpdate(double rating) {
  debugPrint("rating value is $rating");
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to details screen
      },
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            maxWidth: 260,
            maxHeight: 325,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade400, width: 2.0),
          ),
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(children: [
            Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              width: 260,
              height: 200,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop),
                          Text(widget.location),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  RatingBar.builder(
                    itemBuilder: (context, _) {
                      return Icon(Icons.star, color: Colors.yellow.shade700);
                    },
                    onRatingUpdate: onRatingUpdate,
                    itemSize: 18,
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
