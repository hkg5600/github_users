import 'package:githubusers/src/model/git_user.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:http/http.dart';

class GitUserApi {
  Client client = Client();

  Future<List<GitUser>> getGitUser(int index) async {
    final response = await client.get(
        "https://api.github.com/users?since=$index",
        headers: {'Authorization': 'your_github_token'});

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => GitUser.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
