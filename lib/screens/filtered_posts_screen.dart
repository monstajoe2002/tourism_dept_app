import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/post_card.dart';
import 'loading_screen.dart';

class FilteredPostsScreen extends StatelessWidget {
  FilteredPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final postsInstance = FirebaseFirestore.instance.collection('posts');
    final query = postsInstance
        .where('type', isEqualTo: args['categoryFilter'])
        .where('name', isEqualTo: args['searchParam']);

    final stream = query.snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(args['categoryFilter'].toString()),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingScreen();
                }
                if (!snapshot.hasData) {
                  return LoadingScreen();
                }
                var posts = snapshot.data!.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var document = posts[index].data() as Map;
                    return PostCard(
                        title: document['name'],
                        location: document['location'],
                        imageUrl: document['imageUrl'],
                        category: document['type']);
                  },
                  itemCount: posts.length,
                );
              }),
        ),
      ),
    );
  }
}
