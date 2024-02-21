import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v1.dart';

class PostMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> postImage(
      {required Uint8List post,
      required String description,
      required String uid,
      required String username,
      required String profileImage}) async {
    String res = "Some error occured";
    try {
      String postUrl = await StorageMethods().uploadImage('posts', post, true);
      User user = _auth.currentUser!;
      String postId = Uuid().v1();
      Posts posts = Posts(
          uid: user.uid,
          postUrl: postUrl,
          description: description,
          likes: [],
          datePublished: DateTime.now(),
          postId: postId,
          username: username,
          profileImage: profileImage);
      _firestore.collection('posts').add(posts.toJson());
      res = 'Post successfull';
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
