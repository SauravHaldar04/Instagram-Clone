import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String bio;
  final String profilepic;
  final List followers;
  final List following;

  User(
      {required this.uid,
      required this.email,
      required this.username,
      required this.bio,
      required this.profilepic,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'bio': bio,
      'profilepic': profilepic,
      'followers': followers,
      'following': following
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return User(
        uid: snapshot['uid'],
        email: snapshot['email'],
        username: snapshot['username'],
        bio: snapshot['bio'],
        profilepic: snapshot['profilepic'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}
