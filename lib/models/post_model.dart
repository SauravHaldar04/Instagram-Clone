import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String uid;
  final String postUrl;
  final String description;
  final List  likes;
  final String postId;
  final  datePublished;
  final String username;
  final String profileImage;

  const Posts(
      {required this.postId,
      required this.datePublished,
      required this.username,
      required this.profileImage,
      required this.likes,
      required this.uid,
      required this.postUrl,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'postUrl': postUrl,
      'description': description,
      'likes': likes,
      'postId': postId,
      'username': username,
      'profileImage': profileImage,
      'datePublished': datePublished
    };
  }

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Posts(
        uid: snapshot['uid'],
        description: snapshot['description'],
        postUrl: snapshot['postUrl'],
        likes: snapshot['likes'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profileImage: snapshot['profileImage']);
  }
}
