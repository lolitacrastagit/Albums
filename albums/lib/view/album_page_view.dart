import 'package:albums/bloc/album_bloc.dart';
import 'package:albums/bloc/event_state.dart';
import 'package:albums/network/album_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumPageView extends StatefulWidget {
  const AlbumPageView({super.key});

  @override
  State<AlbumPageView> createState() => _InfinitePageViewState();
}

class _InfinitePageViewState extends State<AlbumPageView> {
  final ScrollController controller = ScrollController();
  late List<String> _messages;
  int totalCount = 100;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    _messages =
        List.generate(totalCount, (i) => 'Message   #${totalCount - i}');
  }

  void scrollListener() async {
    var max = controller.position.maxScrollExtent;
    var offset = controller.offset;

    if (controller.position.atEdge) {
      bool isTop = controller.position.pixels == 0;
      if (isTop) {
        print('isTop');
        _messages.insertAll(0, _messages.getRange(0, totalCount));
      } else {
        print('isBottom');
        _messages.addAll(_messages.getRange(0, totalCount));
      }
      setState(() {
        totalCount = _messages.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AlbumBloc(LoadingState())..add(FetchAlbumsEvent()),
        child: Scaffold(
            body: getBlocStates(),
            backgroundColor: Colors.amber,
            appBar: AppBar(
              title: const Text('Albums'),
            )));
  }

  Widget getBlocStates(){
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DataLoadedState) {
          var data = state.albumModel;
          return getListView(data);
        }
        return const Center(child: Text('Something went wrong'));
      });
  }

  Widget getListView(List<AlbumModel> data) {
   return ListView.builder(
        controller: controller,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(data[index].title);
        });
  }
}
