import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eve_mobile/providers/user_provider.dart';
import 'package:eve_mobile/widgets/dashboard/home/movies_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future? _getUserFuture;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _getUserFuture = Provider.of<UserProvider>(context, listen: false).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<UserProvider>(builder: (context, userProvider, child) {
              return MoviesList(moviesList: userProvider.user.observableMovies);
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
