import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/comment_methods.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final List likes;
  final String commentId;
  final String postId;
  final String profileImage;
  final String username;
  final String commentContent;
  final String datePublished;
  const CommentCard(
      {super.key,
      required this.username,
      required this.commentContent,
      required this.datePublished,
      required this.profileImage,
      required this.postId,
      required this.likes,
      required this.commentId});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profileImage),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.commentContent),
                  Text(
                    widget.datePublished,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              LikeAnimation(
                onEnd: () {},
                smallLike: true,
                isAnimating: widget.likes.contains(user.uid),
                child: IconButton(
                    onPressed: () async {
                      await CommentMethods().likeComment(widget.postId,
                          user.uid, widget.commentId, widget.likes);
                    },
                    icon: widget.likes.contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            size: 16,
                          )),
              ),
              if (widget.likes.isNotEmpty) Text('${widget.likes.length}')
            ],
          )
        ],
      ),
    );
  }
}
