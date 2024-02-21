import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentId;
  final String uid;
  final String description;
  final List likes;
  final String postId;
  final datePublished;
  final String username;
  final String profileImage;

  const Comment(
      {
        required this.commentId,
        required this.postId,
      required this.datePublished,
      required this.username,
      required this.profileImage,
      required this.likes,
      required this.uid,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      'commentId':commentId,
      'uid': uid,
      'description': description,
      'likes': likes,
      'postId': postId,
      'username': username,
      'profileImage': profileImage,
      'datePublished': datePublished
    };
  }

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Comment(
      commentId: snapshot['commentId'],
        uid: snapshot['uid'],
        description: snapshot['description'],
        likes: snapshot['likes'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profileImage: snapshot['profileImage']);
  }
}
