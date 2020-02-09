import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/congress_bloc.dart';

class CongressRankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final congressmanRankingList =
        BlocProvider.of<CongressBloc>(context).congressPeopleInRanking;
    return Scaffold(
      appBar: AppBar(
        title: Text('Most Liked Congresspeople'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => ListTile(
          leading: Text((i + 1).toString()),
          title: Text(congressmanRankingList[i].nome),
          trailing: Text(congressmanRankingList[i].likers.length.toString()),
        ),
        separatorBuilder: (_, i) => Divider(),
        itemCount: congressmanRankingList.length,
      ),
    );
  }
}
