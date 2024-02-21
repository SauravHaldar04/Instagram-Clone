import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> pages = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  Text('likes'),
  Text('profile'),
];
