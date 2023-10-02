import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/constants.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Post'),
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ///
              //
              
            },
          ),
        ),
        body: Center(
          child: Column(
            children: const [
              Icon(Icons.add),
              Text('Add Post'),
            ],
          ),
        ),
      ),
    );
  }
}
 