import 'package:albums/bloc/event_state.dart';
import 'package:albums/network/album_model.dart';
import 'package:albums/network/albums_model.dart';
import 'package:albums/network/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<FetchDataEvent, AlbumState> {
  AlbumBloc(super.initialState) {
    on<FetchAlbumsEvent>((event, emit) async {
      List<AlbumsModel> albums = await ApiService().fetchAlbums(
          "/Albums");
      print("reached events");
      List<AlbumModel> data = await getAlbumModel(albums);
      emit(DataLoadedState(data));
    });
    on<RefreshDataEvent>((event, emit){
      emit(DataLoadedState(event.albumModel));
    });
  }

  getAlbumModel(List<AlbumsModel> albumsModel) async {
    final futures = albumsModel.map((album) async {
      Map<String, String> id = {
        'albumId': '${album.id}',
      };
      AlbumModel albumModel = AlbumModel();
      albumModel.title = album.title!;
      albumModel.imgUrls = await ApiService().fetchDetails("/Albums", queryParams: id);
      return albumModel;
    });
    print("reached album model");
    return await Future.wait(futures);
  }


}