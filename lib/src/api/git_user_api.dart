import 'package:githubusers/src/model/git_user.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:http/http.dart';

class GitUserApi {
  Client client = Client();

  Future<List<GitUser>> getGitUser(int index) async {
    final response = await client.get(
        "https://api.github.com/users?since=$index",
        headers: {'Authorization': 'c3aa1d0d70dc4c914e83a4d48be018e21099f74d'});

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => GitUser.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
