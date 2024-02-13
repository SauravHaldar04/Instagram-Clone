import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';

const webScreenSize = 600;

  List<Widget> pages = [
    Text('feed'),
    Text('search'),
    AddPostScreen(),
    Text('likes'),
    Text('profile'),
  ];