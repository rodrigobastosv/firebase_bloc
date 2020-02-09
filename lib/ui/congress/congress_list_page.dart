import 'package:firebase_bloc/ui/bloc/bloc.dart';
import 'package:firebase_bloc/ui/congress/congress_ranking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'congress_list.dart';

class CongressListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congressman List'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<CongressBloc>(context),
                    child: CongressRankingPage(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.stars),
          ),
        ],
      ),
      body: BlocConsumer<CongressBloc, CongressState>(
        listener: _getCongressListListener(),
        builder: _getCongressListBuilder(context),
      ),
    );
  }

  BlocWidgetBuilder<CongressState> _getCongressListBuilder(
      BuildContext context) {
    return (_, state) {
      final congressPeople =
          BlocProvider.of<CongressBloc>(context).congressPeople;
      if (state is InitialCongressState || state is CongressLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CongressLoadedState) {
        return CongressList(congressPeople);
      } else if (state is CongressLikedState) {
        return CongressList(congressPeople);
      } else if (state is CongressUnlikedState) {
        return CongressList(congressPeople);
      } else if (state is CongressLoadedFailledState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is CongressLikedFailledState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else if (state is CongressUnlikedFailledState) {
        return Center(
          child: Text(state.errorMessage),
        );
      }
      return SizedBox.shrink();
    };
  }

  BlocWidgetListener<CongressState> _getCongressListListener() {
    return (_, state) {
      if (state is CongressLikedState) {
        Scaffold.of(_).showSnackBar(
          SnackBar(
            content: Text('${state.congressman.nome} was liked!'),
          ),
        );
      }
      if (state is CongressUnlikedState) {
        Scaffold.of(_).showSnackBar(
          SnackBar(
            content: Text('${state.congressman.nome} was unliked!'),
          ),
        );
      }
    };
  }
}
