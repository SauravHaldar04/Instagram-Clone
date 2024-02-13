import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/utils/utils.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential.user!.uid);
        String profilepic =
            await StorageMethods().uploadImage('profilepics', file, false);

        model.User user = model.User(
            uid: userCredential.user!.uid,
            email: email,
            username: username,
            bio: bio,
            profilepic: profilepic,
            followers: [],
            following: []);
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        res = "Success";
      } else {
        res = 'Please enter all the fields';
      }
      return res;
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = 'Please enter all the fields';
      }
      return res;
    } catch (err) {
      return err.toString();
    }
  }

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    print(currentUser.email);
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    // print((snap.data() as Map<String, dynamic>)['username'] as String);

    return model.User.fromSnap(snap);
  }
}
