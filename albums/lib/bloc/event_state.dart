


import '../network/album_model.dart';

class AlbumState {}
class LoadingState extends AlbumState {}
class DataLoadedState extends AlbumState {
  final AlbumModel albumModel;
  DataLoadedState(this.albumModel);
}
class ErrorState extends AlbumState {}
class FetchDataEvent {}
class FetchDetailsEvent extends FetchDataEvent{}
class FetchAlbumsEvent extends FetchDataEvent{}

