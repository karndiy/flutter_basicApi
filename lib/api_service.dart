// lib/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'post.dart'; // Ensure this file exists for the Post model

class ApiService {
  final String usersUrl = "https://jsonplaceholder.typicode.com/users";
  final String postsUrl = "https://jsonplaceholder.typicode.com/posts";

  // Fetch users
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(usersUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users");
    }
  }

  // Fetch user by ID
  Future<User> fetchUserById(int id) async {
    final response = await http.get(Uri.parse('$usersUrl/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load user details");
    }
  }

  // Fetch posts
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  // Fetch post by ID
  Future<Post> fetchPostById(int id) async {
    final response = await http.get(Uri.parse('$postsUrl/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load post details");
    }
  }
}
