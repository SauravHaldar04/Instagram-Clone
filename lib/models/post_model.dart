import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String uid;
  final String postUrl;
  final String description;
  final int likes;
  final List<String> comments;

  const Posts(
      {required this.comments,required this.likes,required this.uid, required this.postUrl, required this.description});

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'postUrl': postUrl, 'description': description,'likes':likes,'comments':comments};
  }

  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    print(snapshot.toString());
    return Posts(
      uid: snapshot['uid'],
      description: snapshot['description'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      comments: snapshot['comments']
    );
  }
}
