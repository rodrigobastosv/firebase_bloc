import 'package:firebase_bloc/model/congressman_model.dart';
import 'package:firebase_bloc/ui/user_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class CongressList extends StatelessWidget {
  CongressList(this.congressPeople);

  final List<CongressmanModel> congressPeople;

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).userData;
    return ListView.separated(
      itemBuilder: (_, i) => CongressmanTile(congressPeople[i], user['uid']),
      separatorBuilder: (_, i) => Divider(),
      itemCount: congressPeople.length,
    );
  }
}

class CongressmanTile extends StatelessWidget {
  CongressmanTile(this.congressman, this.userId);

  final CongressmanModel congressman;
  final String userId;

  bool get userIsLiking => congressman.likers.contains(userId);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(congressman.id),
      title: Text(congressman.nome),
      trailing: GestureDetector(
        onTap: () => BlocProvider.of<CongressBloc>(context).add(userIsLiking
            ? CongressUnliked(congressman, userId)
            : CongressLiked(congressman, userId)),
        child: Icon(
          userIsLiking ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
