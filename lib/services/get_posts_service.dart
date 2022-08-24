import 'package:textimo_mobile_app/models/post.dart';
import 'package:http/http.dart' as http;

class GetPostsService{
  Future<List<Post>?> getPosts() async{
    var client = http.Client();
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response =  await client.get(uri);
    if(response.statusCode == 200){
      var json = response.body;
      return postFromJson(json);
    }
    
  }
}


// http.get(Uri.parse('url')).timeout(
//   const Duration(seconds: 1),
//   onTimeout: () {
//     // Time has run out, do what you wanted to do.
//     return http.Response('Error', 408); // Request Timeout response status code
//   },
// );