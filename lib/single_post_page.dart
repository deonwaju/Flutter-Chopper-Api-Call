import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'data/post_api_service.dart';
import 'package:provider/provider.dart';
import 'dart:convert';


//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());

class SinglePostPage extends StatelessWidget {
 final int postId;

 const SinglePostPage({
   Key key,
   this.postId,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single call'),
      ),
      body: FutureBuilder<Response> (
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data.bodyString);
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Padding _buildPost(Map post) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post['title'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(post['body']),
        ],
      ),);
  }





}
