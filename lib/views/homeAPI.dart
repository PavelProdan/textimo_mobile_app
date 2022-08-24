// ignore: file_names
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../services/get_posts_service.dart';
// ignore_for_file: prefer_const_constructors


class homeAPI extends StatefulWidget {
  const homeAPI({Key? key}) : super(key: key);

  @override
  State<homeAPI> createState() => _homeAPIState();
}

class _homeAPIState extends State<homeAPI> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    posts =  await GetPostsService().getPosts();
    if(posts != null){
      setState(() {
        isLoaded=true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Visibility(
        visible: isLoaded,
        // ignore: sort_child_properties_last
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(posts![index].title),
            );
          },
        ),
      
        replacement:const Center(
          child: CircularProgressIndicator(),
        ),
      )
    );

    
  }
}