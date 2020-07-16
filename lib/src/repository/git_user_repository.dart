import 'package:githubusers/src/model/git_user.dart';
import 'package:githubusers/src/api/git_user_api.dart';

class GitUserRepository {
  final gitUserApi = GitUserApi();

  Future<List<GitUser>> getGitUser(int index) => gitUserApi.getGitUser(index);
}
