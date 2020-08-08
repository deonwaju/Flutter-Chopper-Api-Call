import 'package:flutter/material.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'package:flutter_app_chopper/home_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//the provider widget will wrap the root materialapp
    return Provider(
//      the postapiservice is initialized here
        builder: (_) => PostApiService.create(),
//        dispose is used to release unneeded resources
        dispose: (_, PostApiService service) => service.client.dispose(),
        child: MaterialApp(
          title: 'Material App',
          home: HomePage(),
        ));
  }
}
