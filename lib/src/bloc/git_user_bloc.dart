import 'package:githubusers/src/model/git_user.dart';
import 'package:githubusers/src/repository/git_user_repository.dart';
import 'package:rxdart/rxdart.dart';

class GitUserBloc {
  final _gitUserRepository = GitUserRepository();
  final _gitUserData = PublishSubject<List<GitUser>>();

  Observable<List<GitUser>> get gitUserData => _gitUserData.stream;
  List<GitUser> allGitUserData = [];

  getGitUser(int index) async {
    if (index == 0) allGitUserData.clear();

    List<GitUser> gitUserDataList = await _gitUserRepository.getGitUser(index);

    allGitUserData.addAll(gitUserDataList);

    _gitUserData.sink.add(allGitUserData);
  }

  dispose() {
    _gitUserData.close();
  }
}
