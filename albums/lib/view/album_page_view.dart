import 'package:albums/bloc/album_bloc.dart';
import 'package:albums/bloc/event_state.dart';
import 'package:albums/network/album_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../network/album_detail_model.dart';
import '../widgets/widgets.dart';

class AlbumPageView extends StatefulWidget {
  const AlbumPageView({super.key});

  @override
  State<AlbumPageView> createState() => _InfinitePageViewState();
}

class _InfinitePageViewState extends State<AlbumPageView> {
  final ScrollController controller = ScrollController();
  int totalCount = 100;
  List<AlbumModel> data = [];
  AlbumBloc? bloc;
  double currentlength = 0.0;
  List<AlbumDetailModel> imgUrls = [];
  AlbumModel? albumModel = null;

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);

  }

  void scrollListener() async {
    if (controller.position.atEdge) {
      bool isTop = controller.position.pixels == 0;
      if (isTop) {
        print('isTop');
        currentlength = data.length - 1;
        data.insertAll(0, data.getRange(0, data.length-1));
        controller.jumpTo(currentlength);
      } else {
        print('isBottom');
        data.addAll(data.getRange(0, data.length-1));
      }
      print('reached refresh');
      if(bloc != null) {
        bloc!.add(RefreshDataEvent(data));
      }
    }
  }

  void horizontalScrollListener() async {
    if (albumModel != null) {
      if (albumModel!.horizontalController.position.atEdge ) {
        imgUrls = albumModel!.imgUrls;
        bool isTop = albumModel!.horizontalController.position.pixels == 0;
        if (isTop) {
          print('isTop');
          currentlength = imgUrls.length - 1;
          imgUrls.insertAll(0, imgUrls.getRange(0, imgUrls.length - 1));
          albumModel!.horizontalController.jumpTo(currentlength);
        } else {
          print('isBottom');
          imgUrls.addAll(imgUrls.getRange(0, imgUrls.length - 1));
        }
        print('reached horizontal refresh');
        if (bloc != null) {
          for (var d in data) {
            if (d.title == albumModel?.title) {
              d.imgUrls = imgUrls;
            }
          }
          bloc!.add(RefreshDataEvent(data));
        }
      }
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
        bloc = context.read<AlbumBloc>();
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
    this.data = data;
   return ListView.builder(
        controller: controller,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          this.albumModel = data[index];
          this.albumModel?.horizontalController.addListener(horizontalScrollListener);
          return Column(
            children: [
              getAlbumTitle(albumTitle: data[index].title),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  controller: data[index].horizontalController,
                  scrollDirection: Axis.horizontal,
                  itemCount: data[index].imgUrls.length,
                  padding: const EdgeInsets.all(20.0),
                  itemBuilder: (BuildContext context,int i){
                    if(data[index].imgUrls[i].thumbnailUrl != null){
                      return getImage(imageUrl: data[index].imgUrls[i].thumbnailUrl);
                    } else {
                      return getImage();
                    }

          },))
            ],
          );
        });
  }
}
