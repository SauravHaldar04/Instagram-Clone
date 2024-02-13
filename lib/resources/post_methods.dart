import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class PostMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> postImage(
      {required Uint8List post, required String description}) async {
    String res = "Some error occured";
    try {
      String postUrl = await StorageMethods().uploadImage('posts', post, true);
      User user = _auth.currentUser!;
      Posts posts = Posts(
          uid: user.uid,
          postUrl: postUrl,
          description: description,
          likes: 0,
          comments: []);
      _firestore.collection('posts').add(posts.toJson());
      res = 'Post successfull';
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
