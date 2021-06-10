import 'package:flutter/cupertino.dart';
import 'package:eve_mobile/models/movie_model.dart';

class SingleMovie extends StatelessWidget {
  final Movie movie;

  const SingleMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: CupertinoColors.systemRed,
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: 25),
        Text('${movie.title} (${movie.year})'),
        SizedBox(height: 25),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text('Here should be some description, but we do not collect it just yet'))
      ],
    );
  }
}
