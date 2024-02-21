import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/comment_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/comment_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();

    void addComment(
        String postId, String uid, String username, String profileImage) async {
      try {
        String res = await CommentMethods().addComment(
            postId: postId,
            description: _commentController.text,
            uid: uid,
            username: username,
            profileImage: profileImage);
        showSnackBar(context, res);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }

    User user = Provider.of<UserProvider>(context).getUser();
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: const Text("Comments"),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profilepic),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                          hintText: 'Comment as ${user.username}',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addComment(widget.snap['postId'], user.uid, user.username,
                        user.profilepic);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: blueColor),
                  ),
                )
              ],
            ),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  likes: snapshot.data!.docs[index]['likes'],
                  commentId: snapshot.data!.docs[index]['commentId'],
                  postId:snapshot.data!.docs[index]['postId'] ,
                  profileImage: snapshot.data!.docs[index]['profileImage'],
                  username: snapshot.data!.docs[index]['username'],
                  commentContent: snapshot.data!.docs[index]['description'],
                  datePublished: DateFormat.yMMMd().format(
                      snapshot.data!.docs[index]['datePublished'].toDate()),
                );
              },
            );
          },
        ));
  }
}
