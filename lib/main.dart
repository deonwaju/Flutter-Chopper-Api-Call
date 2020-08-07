import 'package:flutter/material.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'package:flutter_app_chopper/home_page.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(builder: (_) => PostApiService.create(),
    dispose: (_, PostApiService service) => service.client.dispose(),
    child: MaterialApp(
      title: 'Chopper Api Call',
      home: HomePage(),
      )
    );
  }
}
