import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:githubusers/src/bloc/git_user_bloc.dart';
import 'package:githubusers/src/model/git_user.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: GitUserProvider(
        child: UserList(),
      ),
    );
  }
}

class GitUserProvider extends InheritedWidget {
  final GitUserBloc gitUserBloc;

  GitUserProvider({Key key, GitUserBloc getGitUserDataBloc, Widget child})
      : gitUserBloc = getGitUserDataBloc ?? GitUserBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GitUserProvider>()
        .gitUserBloc;
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gitUserBloc = GitUserProvider.of(context);
    gitUserBloc.getGitUser(0);
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub Users!"),
      ),
      body: StreamBuilder(
        stream: gitUserBloc.gitUserData,
        builder: (context, AsyncSnapshot<List<GitUser>> snapshot) {
          if (snapshot.hasData) {
            return GitUserList(
              snapshot: snapshot,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class GitUserList extends StatelessWidget {
  final AsyncSnapshot<List<GitUser>> snapshot;

  GitUserList({this.snapshot});

  GitUserBloc getGitUserDataBloc;

  @override
  Widget build(BuildContext context) {
    getGitUserDataBloc = GitUserProvider.of(context);
    debugPrint("In List : " + getGitUserDataBloc.hashCode.toString());
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 10),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext _context, int i) {
          if (i >= snapshot.data.length - 1) {
            getGitUserDataBloc.getGitUser(snapshot.data[i].id);
          }
          return _buildTile(context, i);
        });
  }

  Widget _buildTile(BuildContext context, int i) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
          title: Text(
            snapshot.data[i].login,
            style: TextStyle(fontSize: 18),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              snapshot.data[i].avatarUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {},
        ));
  }
}
