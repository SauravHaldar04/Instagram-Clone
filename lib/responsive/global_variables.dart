import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> pages = [
  const FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('likes'),
  Text('profile'),
];
