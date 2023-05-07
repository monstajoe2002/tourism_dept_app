import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
        child: Column(children: [
          Image.network(
            'https://picsum.photos/256/235',
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'National Museum',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: const [
                          Icon(Icons.pin_drop),
                          Text('Cairo'),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                    
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                      Icon(Icons.star, color: Colors.yellow.shade700, size: 20),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
