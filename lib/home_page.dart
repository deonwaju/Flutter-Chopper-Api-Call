import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'package:provider/provider.dart';

import 'data/post_api_service.dart';
import 'single_post_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
//            this is how the
            final response = await Provider.of<PostApiService>(context)
                .postPost({'key': 'value'});
            print(response.body);
          }),
    );
  }
}

FutureBuilder<Response> _buildBody(BuildContext context) {
// FutureBuilder can be used easily for building UI when awaiting a Future Response is the type currently returned by all the methods of PostApiService

  return FutureBuilder<Response>(
    future: Provider.of<PostApiService>(context).getPosts(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
// display a list of data when page loads completely and successfully
        final List posts = json.decode(snapshot.data.bodyString);
        return _buildPosts(context, posts);
      } else {
        return Center(
// used to initialize a loading icon or indicator while post is loading
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

ListView _buildPosts(BuildContext context, List posts) {
  return ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            posts[index]['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[index]['body']),
//          call the navigation method
          onTap: () => _navigateToPost(context, posts[index]['id']),
        ),
      );
    },
  );
}

//          method for navigating to the next page
void _navigateToPost(BuildContext context, int id) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => SinglePostPage(postId: id),
    ),
  );
}
