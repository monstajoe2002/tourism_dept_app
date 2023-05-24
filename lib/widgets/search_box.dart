import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              final collection = FirebaseFirestore.instance.collection('posts');
              collection
                  .where('name', isEqualTo: _searchController.text)
                  .get()
                  .then((value) => value.docs.forEach((element) {
                        print(element.data());
                      }));
            },
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
              // Add a clear button to the search b
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _searchController.clear(),
              ),
              // Add a search icon or button to the search bar
              prefixIcon: const IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ));
  }
}
