


import '../network/album_model.dart';

class AlbumState {}
class LoadingState extends AlbumState {}
class DataLoadedState extends AlbumState {
  final List<AlbumModel> albumModel;
  DataLoadedState(this.albumModel);
}
class ErrorState extends AlbumState {}
class FetchDataEvent {}
class FetchAlbumsEvent extends FetchDataEvent{}

