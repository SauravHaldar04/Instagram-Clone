import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:uuid/uuid.dart';

class CommentMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> addComment(
      {required String postId,
      required String description,
      required String uid,
      required String username,
      required String profileImage}) async {
    String res = "Some error occured";
    try {
      User user = _auth.currentUser!;
      String commentId = Uuid().v1();
      Comment comment = Comment(
        commentId: commentId,
          uid: user.uid,
          description: description,
          likes: [],
          datePublished: DateTime.now(),
          postId: postId,
          username: username,
          profileImage: profileImage);
      _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set(comment.toJson());
      res = 'Comment successfull';
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> likeComment(String postId, String uid, String commentId,List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

